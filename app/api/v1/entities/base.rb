# frozen_string_literal: true

module V1
  module Entities
    class Base < Grape::Entity
      include ValidationValuable

      format_with(:iso8601) {|t| t.to_s(:crix_iso8601) if t}
      format_with(:decimal) {|d| d.to_d.round(8, BigDecimal::ROUND_DOWN).to_s('F') if d}
      format_with(:full_decimal) {|d| d.to_s('F') if d}
      format_with(:truncated_decimal) {|d| d.to_s.gsub(/.0$/, '') if d}
      format_with(:unix_epoch_second) {|i| i.to_i if i}
    end
  end
end
