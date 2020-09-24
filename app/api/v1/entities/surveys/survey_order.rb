# frozen_string_literal: true

module V1
  module Entities
    module Surveys
      class SurveyOrder < Base
        # @formatter:off
        expose :uuid,       documentation: {type: String, desc: '주문 아이디', allow_blank: false}
        expose :volume,     documentation: {type: BigDecimal, desc: '수요조사 주문 수량', allow_blank: false}, format_with: :decimal
        expose :price,      documentation: {type: BigDecimal, desc: '수요조사 주문 가격', allow_blank: false}, format_with: :decimal
        expose :state,      documentation: {type: String, desc: '주문 상태', example: 'wait', allow_blank: false}
        expose :created_at, documentation: {type: DateTime, desc: '주문시각'}, format_with: :iso8601
        # @formatter:on
      end
    end
  end
end
