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

    def receipt(response_code)
      payment_intent = show(response_code)
      charges = payment_intent.params['charges']['data']
      charges&.last['payment_method_details']['card_present']['receipt']
    end

    def create_profile(_payment)
      return
    end

    def cancel(response_code)
      _payment = Spree::Payment.valid.where(
        response_code: response_code,
        source_type:   payment_source_class.to_s
      ).first

      return if _payment.nil?

      if _payment.pending?
        _payment.void_transaction!
      elsif _payment.completed? && _payment.can_credit?
        provider.refund(_payment.credit_allowed.to_money.cents, response_code)
      end
    end

  end
end
