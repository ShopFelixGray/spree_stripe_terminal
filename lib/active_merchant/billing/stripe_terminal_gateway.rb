module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    # This gateway uses the current Stripe {Payment Intents API}[https://stripe.com/docs/api/payment_intents].
    # For the legacy API, see the Stripe gateway
    class StripeTerminalGateway < StripePaymentIntentsGateway
      def create_intent(money, _payment_method, options = {})
        post = {}
        add_amount(post, money, options, true)
        add_capture_method(post, options)
        add_payment_method_types(post, options)

        CREATE_INTENT_ATTRIBUTES.each do |attribute|
          add_whitelisted_attribute(post, options, attribute)
        end

        commit(:post, 'payment_intents', post, options)
      end

      def add_payment_method_types(post, _options)
        post[:payment_method_types] = ['card_present']
        post
      end
    end
  end
end
