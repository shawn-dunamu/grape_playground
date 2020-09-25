# frozen_string_literal: true

module V1
  class Surveys < Grape::API
    helpers do
    end

    desc('Form Create') do
      entity V1::Entities::Surveys::SurveyCreate
      detail Tool.load('/v1/surveys/form_create')
    end
    params do

    end
    post '/surveys' do
      params = {
          title: '폼 메인 타이틀',
          desc: '폼 메인 Description',
          questions: [{
                          type: 'multi_choice',
                          title: '질문지 타이틀',
                          desc: '질문지 description',
                          order: 1,
                          optional_questions: [{
                                                   option: '멀티초이스 1번 옵션',
                                                   order: 1
                                               }, {
                                                   option: '멀티초이스 2번 옵션',
                                                   order: 2
                                               }]
                      }, {
                          type: 'checkbox',
                          title: '질문지 타이틀',
                          desc: '질문지 description',
                          order: 2,
                          optional_questions: [{
                                                   option: '체크박스 1번 옵션',
                                                   order: 1
                                               }, {
                                                   option: '체크박스 2번 옵션',
                                                   order: 2
                                               }]
                      }, {
                          type: 'essay_answer',
                          title: '서술형 질문지 타이틀',
                          desc: '서술형 질문지 description',
                          example: '서술형 유저에게 노출되는 예시)',
                          order: 3
                      }, {
                          type: 'short_answer',
                          title: '단문항 타이틀',
                          desc: '단문항 description',
                          example: '단문항 유저에게 노출되는 예시)',
                          order: 4
                      }]

      }

      survey = Survey.submit!(params)

      present survey, with: V1::Entities::Surveys::SurveyCreate
    end
  end
end