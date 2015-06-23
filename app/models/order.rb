class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]

  validates :name, :address, :email, presence: true
  # old payment type check
  # validates :pay_type, inclusion: PAYMENT_TYPES
  validates_each :pay_type do |model, attr, value|
    if !PaymentType.names.include?(value)
      model.errors.add(attr, "Payment type not on the list")
    end
  end

  def add_line_items_from_cart(cart)
  	cart.line_items.each do |item|
  		item.cart_id = nil
  		line_items << item
  	end
  end
end
