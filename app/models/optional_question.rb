# frozen_string_literal: true

class OptionalQuestion < ApplicationRecord
  belongs_to :survey_question, class_name: 'SurveyQuestion', optional: true
end
