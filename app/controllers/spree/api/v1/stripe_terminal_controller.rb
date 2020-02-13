module Spree
  module Api
    module V1
      class StripeTerminalController < Spree::Api::BaseController
        before_action :find_order, only: [:create_payment_intent, :capture_payment_intent]
        before_action :find_payment, only: :capture_payment_intent

        def create_payment_intent
          validate_payments_attributes([payment_params])
          # Clear out all the pending payments
          @order.payments.pending.each(&:void!)
          @payment = @order.payments.build(payment_params)
          # Make sure to use physical credit card otherwise we can't
          # process the payment
          @payment.source = Spree::PhysicalCreditCard.new
          if @payment.save
            # Authorize the charge so stripe gateway can proceed
            @payment.authorize!
            # We need to send back the client secret for the terminal
            # This isn't saved anywhere in spree so we need to make another
            # request to stripe to get the value from the response params
            payment_intent = @payment.payment_method.show(@payment.response_code)
            client_secret = payment_intent.params['client_secret']
            render status: 201, json: { :payment_id => @payment.number, :secret => client_secret }
          else
            invalid_resource!(@payment)
          end
        end

        def capture_payment_intent
          begin
            @payment.capture!
            @order.reload
            while @order.next; end
            # If "@order.next" didn't trigger payment processing already (e.g. if the order was
            # already complete) then trigger it manually now
            @payment.process! if @order.completed? && @payment.checkout?
            render status: 200, json: {}
          rescue Exception => e
            render status: 402, json: {}
          end
        end

        def connection_token
          begin
            token = Stripe::Terminal::ConnectionToken.create
          rescue Stripe::StripeError => e
            render status: 402, json: {}
            return
          end

          render status: 200, json: { :secret => token.secret }.to_json
        end

        private

        def validate_payments_attributes(attributes)
          # Ensure the payment methods specified are allowed for this user
          payment_methods = Spree::PaymentMethod.where(type: 'Spree::Gateway::StripeTerminalGateway')
          attributes.each do |payment_attributes|
            payment_method_id = payment_attributes[:payment_method_id]

            # raise RecordNotFound unless it is an allowed payment method
            payment_methods.find(payment_method_id) if payment_method_id
          end
        end

        def find_order
          @order = Spree::Order.friendly.find(params[:order_id])
          authorize! :read, @order, order_token
        end

        def find_payment
          @payment = @order.payments.friendly.find(params[:id])
        end

        def payment_params
          params.require(:payment).permit(permitted_payment_attributes)
        end
      end
    end
  end
end
