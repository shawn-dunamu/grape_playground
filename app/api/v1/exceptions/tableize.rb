# frozen_string_literal: true

module V1
  module Exceptions
    module Tableize
      extend ActiveSupport::Concern

      class_methods do
        def tr_th
          Tool.s2h (<<~NOTE)
            tr
              td style='font-weight: bold' 
                | 에러 이름
                br
                | (name)
              td style='font-weight: bold' 
                | 다이얼로그
                br
                | (dialog)
              td style='font-weight: bold'
                | 제목
                br
                | (title)
              td style='font-weight: bold; max-width: 30%'
                | 내용
                br
                | (response)
              td style='font-weight: bold' 
                | HTTP
                br
                | 상태코드
          NOTE
        end

        def tr
          id = rand(100000)
          Tool.s2h(<<~NOTE, o: self.new, id: id)
            tr onclick="jQuery('##{id}').toggle();" style='cursor: pointer;'
              td = o.class.name
              td = o.dialog
              td = o.title
              td style='max-width: 300px' = o.body
              td = o.status
            tr id=id style="display: none;"
              td colspan=5 style='padding-left: 10px'
                h4 =o.class.name
                - if o.description
                  pre style='background-color: #fcf6db;border: 1px solid #e5e0c6;padding: 10px;margin-bottom: 10px;' =o.description
                pre 
                  code.json = JSON.pretty_generate(o.response)
          NOTE
        end

        def h4
          Tool.s2h(<<~NOTE, o: self.new)
            h4 =o.description + ' (' + o.name + ')'
          NOTE
        end
      end


    end
  end
end
