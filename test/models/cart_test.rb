require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #test create with one product
  def new_cart_with_one_product(product_name)
    cart = Cart.create
    product = products(product_name)
    cart.add_product(product.id, product.price)
    cart
  end

  test 'cart should create a new line item when adding a new product' do
    cart = new_cart_with_one_product(:one)
    assert_equal 1, cart.line_items.count
    #Add a new product
    cart.add_product(products(:ruby).id, products(:ruby).prize)
    assert_equal 2, cart.line_items.count
  end

  test 'cart should update an existing line item when adding an existing product' do
    cart = new_cart_with_one_product(:one)
    # Re-add the same product
    cart.add_product(products(:one).id, products(:one).prize)
    assert_equal 1, cart.line_items.count
  end
end
