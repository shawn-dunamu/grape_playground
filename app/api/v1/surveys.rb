# frozen_string_literal: true

module V1
  class Surveys < Grape::API
    helpers do
    end

    desc('Form Create') do
      entity V1::Entities::Surveys::SurveyOrder
    end
    params do

    end
    post '/surveys' do

      Survey.submit!(params)

      present nil, with: V1::Entities::Surveys::SurveyOrder
    end
  end
end