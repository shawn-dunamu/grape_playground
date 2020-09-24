# frozen_string_literal: true

module V1
  module Exceptions

    class NotFound < Base
      self.group_class  = true

      RAW_QUERY_PATTERN = / with \[[a-zA-Z0-9.` ].*\]/ unless const_defined?(:RAW_QUERY_PATTERN)
      # RAW_QUERY_PATTERN ||= / with \[[a-zA-Z0-9.` ].*\]/

      def initialize(msg = nil, status: 404, **options)
        super msg, status: status, **options
      end

      def formatted_exception(exception)
        message  = exception.try(:message)&.gsub(RAW_QUERY_PATTERN, '')
        callee   = exception.backtrace.first
        words    = callee.split(':')[0..1]
        words[0] = File.basename(words.first || '').gsub(/\.rb/, '') if words.size > 0
        "#{message}on #{words * ':'}"
      rescue
        message
      end
    end

    # 사용자를 찾지못했습니다.
    class MemberNotFound < NotFound
    end

    # 리프레시 토큰을 찾지 못했습니다.
    class RefreshTokenNotFound < NotFound
    end

    # 주문을 찾지 못했습니다.
    class OrderNotFound < NotFound
    end

    # 취소할 수 없는 주문입니다.
    class OrderNotCancelable < NotFound
    end

    # 체결 정보를 찾지 못했습니다.
    class TradeNotFound < NotFound
    end

    # 입출금 정보를 찾지 못했습니다.
    class DepositNotFound < NotFound
    end

    # 출금 정보를 찾지 못했습니다.
    class WithdrawNotFound < NotFound
    end

    # 트랜잭션 정보를 찾지 못했습니다.
    class TransactionNotFound < NotFound
    end

    # 전용번호 정보를 찾지못했습니다.
    class VirtualBankAccountNotFound < NotFound
    end

    class AccountNotFound < NotFound
    end

    # 디지털 자산 지갑정보를 찾지 못했습니다.
    class CoinAddressNotFound < NotFound
    end

    # 요청이 만료되었습니다.
    class TokenExpired < NotFound
    end

    # 이미 사용된 토큰입니다.
    class TokenIsUsed < NotFound
    end

    # 남은 전용번호가 없습니다.
    class ExtraVirtualBankAccountNotFound < NotFound
    end

    # 입금계좌를 찾지 못했습니다.
    class RealNameAccountNotFound < NotFound
    end

    # 출금계좌를 찾지 못했습니다.
    class WithdrawAccountNotFound < NotFound
    end

    # Api토큰을 찾지 못했습니다.
    class ApiTokenNotFound < NotFound
    end

    # Kakao 인증정보를 찾지 못했습니다.
    class KakaoAuthenticationNotFound < NotFound
    end

    # Oauth Applcation을 찾지못했습니다.
    class OauthApplicationNotFound < NotFound
    end

    # Snapshot을 찾지못했습니다.
    class SnapshotNotFound < NotFound
    end

    # 소속 조직 정보를 찾을 수 없습니다.
    class OrganizationNotFound < NotFound
    end

    # 조직에 속한 회원이 아닙니다.
    class NotOrganizationMember < NotFound
    end
  end
end
