# frozen_string_literal: true

module V1
  class Surveys < Grape::API
    helpers do
      params :event do
        requires :uuid, ::V1::Entities::Surveys::SurveyEvent.documentation[:uuid]
      end
    end

    desc('Form Create') do
      entity V1::Entities::Surveys::SurveyOrder
      detail Tool.load('/v1/surveys/post_orders')
    end
    params do
      requires :volume, documentation: {type: BigDecimal, desc: "폼작성", allow_blank: false}
    end
    post '/surveys/create' do
      present nil, with: V1::Entities::Surveys::SurveyOrder
    end
  end
end