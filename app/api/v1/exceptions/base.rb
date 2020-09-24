# frozen_string_literal: true

module V1
  module Exceptions
    # {Grape::Exceptions::Base} 기반으로 만들어진 에러구조체
    class Base < Grape::Exceptions::Base
      include ActiveModel::Validations
      include Stereotype
      include Tableize

      self.abstract_class = true
      self.log_class      = false

      attr_reader :name, :dialog, :title, :body, :message, :origin, :response
      attr_reader :status # http code

      TYPES ||= %w[popup toast none client]
      validates_inclusion_of :dialog, in: TYPES

      def initialize(message = nil, name: self.class.name, title: nil, body: nil, dialog: 'client', status: nil, **_options)
        @name   = name
        @dialog = dialog
        @status = status || (self.class.error_class? ? 500 : nil) || 400
        @title  = title || gen_title(**_options)
        @body   = body || gen_body(**_options)

        if message.is_a?(Exception)
          @origin         = message
          @origin_message = formatted_exception(message)
        else
          @origin_message = message
        end

        @message = response_to_message
        validate!
      end

      def response_to_message
        response[:error].to_s
      end

      def response
        @response ||= {
          error:
            {
              name:    self.name,
              title:   self.title,
              message: self.body,
              dialog:  self.dialog,
              origin:  @origin_message,
            }.reject { |_, value| value.blank? }
        }
      end

      def prefix_key
        self.class.name.gsub('::', '.').to_sym
      end

      def translate(key, **options)
        handler = -> (_, _, _, _) { nil } # I18n.handle_exception
        ::I18n.translate(key, locale: I18n.locale, exception_handler: handler, **options)
      end

      def description(**options)
        translate("#{prefix_key}.description".to_sym, **options)
      end

      def gen_title(**options)
        translate("#{prefix_key}.title".to_sym, **options)
      end

      def gen_body(**options)
        translate("#{prefix_key}.body".to_sym, **options)
      end

      def inspect
        "#{super} status => #{status}, message => #{message}"
      end

      def formatted_exception(exception)
        message  = exception.try(:message)
        callee   = exception.backtrace.first
        words    = callee.split(':')[0..1]
        words[0] = File.basename(words.first || '').gsub(/\.rb/, '') if words.size > 0
        "#{message} on #{words * ':'}"
      rescue
        message
      end
    end
  end
end
