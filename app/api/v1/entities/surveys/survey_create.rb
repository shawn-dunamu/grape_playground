# frozen_string_literal: true

module V1
  module Entities
    module Surveys
      class SurveyCreate < Base
        # @formatter:off
        expose :title,      documentation: {type: String, desc: 'Survey Title', allow_blank: false}
        expose :desc,      documentation: {type: String, desc: 'Survey Desc'}
        expose :uuid,       documentation: {type: String, desc: 'Universal Unique Identifier (UUID)', allow_blank: false}
        expose :created_at, documentation: {type: DateTime, desc: 'CreatedAt'}, format_with: :iso8601
        # @formatter:on
      end
    end
  end
end
