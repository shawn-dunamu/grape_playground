# frozen_string_literal: true

module V1
  module Entities
    module Surveys
      class SurveyTrade < Base
        expose :uuid, documentation: {type: String, desc: '체결 아이디'}

      end
    end
  end
end
