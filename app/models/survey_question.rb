# frozen_string_literal: true

class SurveyQuestion < ApplicationRecord
  belongs_to :survey, class_name: 'Survey', optional: true

  def generate
    raise NotImplementedError
  end
end
