# frozen_string_literal: true

module V1
  module Exceptions
    module Stereotype
      extend ActiveSupport::Concern

      module ClassMethods
        attr_accessor :abstract_class
        attr_accessor :group_class
        attr_accessor :error_class
        attr_accessor :log_class

        def abstract_class?
          defined?(@abstract_class) && @abstract_class == true
        end

        def group_class?
          defined?(@group_class) && @group_class == true
        end
        
        def error_class?
          defined?(@error_class) && @error_class == true
        end

        def log_class?
          defined?(@log_class) && @log_class == false
        end
      end

    end
  end
end
