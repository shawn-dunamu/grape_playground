# frozen_string_literal: true

module Propertiable

  extend ActiveSupport::Concern

  included do |base|
    raise "only ActiveRecord subclass can use propertiable #{base.name}" unless base.ancestors.include? ActiveRecord::Base
    base.after_initialize :set_properties
  end

  def set_properties
    store = PropertyStore.fetch(self.class)
    return unless attribute_names.include? store.attribute.to_s
    raw_write_property_attributes
  end

  def safe_properties
    property_names = PropertyStore.fetch(self.class).attribute
    try("#{property_names}=", ActiveSupport::HashWithIndifferentAccess.new) if try(property_names).nil?
    try(property_names)
  end

  def reload(*)
    raw_write_property_attributes
    super
  end

  private
  def raw_write_property_attributes
    PropertyStore.fetch(self.class).properties.each do |_, property|
      method = get_write_attribute_method
      send(method, property.full_name, send(property.full_name))
    end
  end

  def get_write_attribute_method
    Gem.loaded_specs['rails'].version.version.to_d < 5.2 ? 'raw_write_attribute' : 'write_attribute_without_type_cast'
  end

  class_methods do

    def json_properties(attribute: :properties, &block)
      raise "Can't use propertiable twice in same class" if PropertyStore.fetch(self.class)
      store = PropertyStore.register(self, attribute: attribute)
      store.instance_eval(&block)
    end
  end

  class PropertyStore
    @stores = Concurrent::Map.new

    attr_reader :attribute, :properties

    class << self
      def stores
        @stores
      end

      def register(klass, attribute: :properties)
        raise "Cannot register #{klass}" unless klass.is_a?(Class)
        stores[klass.to_s] = new(klass, attribute)
      end

      alias_method :[]=, :register

      def fetch(klass)
        stores[klass.to_s] || begin
          match = klass.ancestors.find do |ancestor|
            ancestor.include? Propertiable and stores[ancestor.to_s]
          end
          stores[match.to_s]
        end
      end

      alias_method :[], :fetch
    end

    def initialize(klass, attribute)
      @klass      = klass
      @attribute  = attribute
      @properties = Concurrent::Map.new
    end

    def klass
      @klass
    end

    def attribute
      @attribute
    end

    def register(name, property, force: false)
      raise "Cannot use #{name.inspect} for name" unless name.is_a?(Symbol) or name.is_a?(String)

      force ? @properties[name.to_s] = property : @properties[name.to_s] ||= property
    end

    def set_property(prop, initial: nil, prefix: :property, type: nil, scope: false)
      _prefix  = prefix ? prefix.to_s + '_' : nil
      store    = PropertyStore.fetch(klass)
      property = Property.new(prop, initial: initial, prefix: _prefix, type: type)
      store.register(prop, property)

      define_property_methods(property)
      define_scope_method(property) if scope
    end

    alias_method :property, :set_property

    private
    def define_property_methods(property)
      attr_name = property.full_name.to_s
      property_name = property.name.to_s

      klass.send(:attribute, :"#{attr_name}")
      klass.send(:define_method, :"#{attr_name}||=", proc {|arg| safe_properties[property_name] ||= property.cast(arg)})
      klass.send(:define_method, :"#{attr_name}?", proc {!!send(attr_name)})
      klass.send(:define_method, :"#{attr_name}", proc { safe_properties.key?(property_name) ? property.cast(safe_properties[property_name]) : property.initial })
      klass.send(:define_method, :"#{attr_name}=", proc do |arg|
        property.cast(arg).tap do |_arg|
          super(_arg)
          property.initial == _arg ? safe_properties.delete(property_name) : (safe_properties[property_name] = _arg)
        end
      end)
    end

    def define_scope_method(property)
      attr_name = property.full_name
      name = property.name
      attribute_name = attribute
      class_prop = proc do |arg|
                     query = "JSON_EXTRACT(#{attribute_name}, '$.#{name}') = #{arg.to_json}"
                     query = query + " OR JSON_EXTRACT(#{attribute_name}, '$.#{name}') IS NULL" if property.cast(arg) == property.initial
                     self.where(query)
                   end
      klass.define_singleton_method(:"with_#{attr_name}", class_prop)
    end

  end

  class Property
    attr_reader :name, :initial, :prefix, :type

    def initialize(name, initial:, prefix:, type: nil)
      @name    = name
      @initial = initial
      @prefix  = prefix
      @type    = case type
                 when Symbol
                   ActiveModel::Type.lookup(type)
                 when ActiveModel::Type::Value
                   type
                 else
                   raise ArgumentError, "Unknown type #{type.inspect}" if type
                   nil
                 end
    end

    def cast(value)
      result = @type&.cast(value)
      result.nil? ? value : result
    end

    def initial
      cast @initial
    end

    def full_name
      "#{prefix}#{name}"
    end

  end
end
