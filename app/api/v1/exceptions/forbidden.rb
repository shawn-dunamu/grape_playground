# frozen_string_literal: true

module V1
  module Exceptions

    class Forbidden < Base
      self.abstract_class = true
      self.group_class    = true

      def initialize(msg = nil, status: 403, dialog: 'popup', **options)
        super msg, status: status, dialog: dialog, **options
      end
    end

    class UnitCurrencyChange < Forbidden
    end

    class CanNotChangeUseWhitelist < Forbidden
    end

    class CanNotHandleWhitelistDirectly < Forbidden
    end

    class CanNotRequestCmsArs < Forbidden
    end

    class NotSupportedCurrencies < Forbidden
    end

    class SupportedOnlyForCorporateMember < Forbidden
    end

    class NotSupportedForCorporateMember < Forbidden
    end

    class InvestmentEventDisabled < Forbidden
    end

    class IdentityAuthDisabled < Forbidden
    end

  end
end

