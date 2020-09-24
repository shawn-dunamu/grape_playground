# frozen_string_literal: true

module V1
  module Entities
    module Surveys
      class SurveyEvent < Base
        # @formatter:off
        expose :uuid,                      documentation: {type: String, desc: '이벤트 아이디', allow_blank: false}
        expose :market,                    documentation: {desc: "Market  고유 코유 ID, e.g. 'KRW-BTC'"}
        expose :runtime_state, as: :state, documentation: {type: String, desc: '이벤트 상태', values: Survey::Event::RUNTIME_STATES, example: 'prepared', allow_blank: false}
        expose :origin_volume,             documentation: {type: BigDecimal, desc: '전체 물량', allow_blank: false}, format_with: :decimal
        expose :volume,                    documentation: {type: BigDecimal, desc: '현재 볼륨', allow_blank: false}, format_with: :decimal
        expose :price,                     documentation: {type: BigDecimal, desc: '현재가', allow_blank: false}, format_with: :decimal
        expose :top_price,                 documentation: {type: BigDecimal, desc: '시작가', allow_blank: false}, as: :start_price
        expose :started_at,                documentation: {type: DateTime, desc: '이벤트 시작 시각'}, format_with: :iso8601
        expose :ended_at,                  documentation: {type: DateTime, desc: '이벤트 종료 시각'}, format_with: :iso8601
        expose :member_min_volume,         documentation: {type: BigDecimal, desc: '인당 최소 주문 수량', allow_blank: false}, format_with: :decimal
        expose :member_max_volume,         documentation: {type: BigDecimal, desc: '인당 최대 주문 수량', allow_blank: false}, format_with: :decimal
        expose :min_security_level,        documentation: {type: Integer, desc: '이벤트에 참석할수 있는 최소 보안등급', allow_blank: false }
        # @formatter:on

        def volume
          [0, @object.volume].max
        end
      end
    end
  end
end
