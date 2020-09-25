# frozen_string_literal: true

module SurveyQuestions
  class MultiChoice < SurveyQuestion
    has_many :optional_questions, class_name: 'OptionalQuestion'
  end
end

