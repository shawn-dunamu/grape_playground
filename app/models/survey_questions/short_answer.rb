# frozen_string_literal: true

module SurveyQuestions
  class ShortAnswer < SurveyQuestion

    include Propertiable

    json_properties do
      property :example, prefix: nil, initial: nil, type: :string
    end

    def generate(survey, questions)
      self.survey = survey
      self.title = questions[:title]
      self.desc = questions[:desc]
      self.example = questions[:example]
      self.order = questions[:order]

      self.save!
    end
  end
end

