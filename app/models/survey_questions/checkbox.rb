# frozen_string_literal: true

module SurveyQuestions
  class Checkbox < SurveyQuestion
    has_many :optional_questions, class_name: 'OptionalQuestion'
  end

  def generate(survey, questions)

  end
end
