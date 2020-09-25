# frozen_string_literal: true

module SurveyQuestions
  class Checkbox < SurveyQuestion

    def generate(survey, questions)

      self.survey = survey
      self.title = questions[:title]
      self.desc = questions[:desc]
      self.order = questions[:order]

      self.save!

      # FIXME. naming은 바꾸자 나도 헷갈린다.
      questions[:optional_questions].each do |o|
        self.optional_questions.create!(question: o[:option],
                                        order: o[:order])
      end if questions[:optional_questions].is_a?(Array)
    end
  end
end
