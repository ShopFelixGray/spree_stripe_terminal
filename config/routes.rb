Spree::Core::Engine.add_routes do
  # custom API routes
  namespace :api do
    namespace :v1 do
      post '/terminal/connection_token' => 'stripe_terminal#connection_token'
      post '/terminal/create_payment_intent/:order_id' => 'stripe_terminal#create_payment_intent'
      post '/terminal/capture_payment_intent/:order_id/payment/:id' => 'stripe_terminal#capture_payment_intent'
    end
  end
end
