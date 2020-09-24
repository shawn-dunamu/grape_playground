# frozen_string_literal: true

module ValidationValuable
  extend ActiveSupport::Concern

  BOOLEAN_VALUES = [true, false, "true", "false"]
end