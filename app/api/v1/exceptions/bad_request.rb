# frozen_string_literal: true

module V1
  module Exceptions

    class BadRequest < Base
      self.abstract_class = true
      self.group_class    = true
    end

    # 잘못된 파라미터 입니다.
    class InvalidParameter < BadRequest
    end

    # 잘못된 현금영수증 번호 입력
    class InvalidReceiptInfo < BadRequest
    end
  end
end

