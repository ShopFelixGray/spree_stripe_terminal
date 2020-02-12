module Spree
  class PhysicalCreditCard < Spree::CreditCard

  private

  def require_card_numbers?
    false
  end

  end
end
