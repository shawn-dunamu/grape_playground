# frozen_string_literal: true

class SurveyQuestion < ApplicationRecord
  belongs_to :survey, class_name: 'Survey', optional: true
  has_many :optional_questions, class_name: 'OptionalQuestion'

  def generate
    raise NotImplementedError
  end
end
