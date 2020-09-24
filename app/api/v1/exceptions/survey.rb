# frozen_string_literal: true

module V1
  module Exceptions

    class Survey < Base
      self.abstract_class = true
      self.group_class    = true

      def initialize(msg = nil, status: 400, dialog: 'client', **options)
        super msg, status: status, dialog: dialog, **options
      end
    end
  end
end
