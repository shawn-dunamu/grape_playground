# frozen_string_literal: true

module V1
  module Entities
    module Surveys
      class SurveyConfirmation < Base
        expose(:event_uuid, documentation: {type: String, desc: '이벤트 아이디', allow_blank: false}){|o,_| o.event.uuid}
        expose(:member_uuid, documentation: {type: String, desc: '이벤트 아이디', allow_blank: false}){|o,_| o.member.uuid}
      end
    end
  end
end

