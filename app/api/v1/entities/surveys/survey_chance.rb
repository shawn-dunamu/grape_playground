# frozen_string_literal: true

module V1
  module Entities
    module Surveys
      class SurveyChance < Base
        # @formatter:off
        expose :event, using: ::V1::Entities::Surveys::SurveyEvent
        expose :quote_account, using: ::V1::Entities::Account
        expose :country_allowed,        documentation: {type: Grape::API::Boolean, desc: '계정 국가 허용 여부'}
        expose :security_level_allowed, documentation: {type: Grape::API::Boolean, desc: '보안등급 허용 여부'}
        expose :confirmation,           documentation: {type: Grape::API::Boolean, desc: '사용자 동의 여부'}
        expose :ordered_volume,         documentation: {type: BigDecimal, desc: '주문한 수량', allow_blank: false}, format_with: :decimal
        expose :available_volume,       documentation: {type: BigDecimal, desc: '주문가능 수량', allow_blank: false}, format_with: :decimal
        # @formatter:on
      end
    end
  end
end
