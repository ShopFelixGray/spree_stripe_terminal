module Spree
  class Gateway::StripeTerminalGateway < Spree::Gateway::StripeGateway
    def method_type
      'stripe_terminal'
    end

    def provider_class
      ActiveMerchant::Billing::StripeTerminalGateway
    end

    def payment_source_class
      PhysicalCreditCard
    end

    def supports?(source)
      source.is_a? payment_source_class
    end

    def purchase(_money, _creditcard, _gateway_options)
      raise NotImplementedError
    end

    def show(response_code)
      provider.show_intent(response_code, {})
    end

    def create_profile(_payment)
      return
    end
  end
end
