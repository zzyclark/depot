require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #test create with one product
  def new_cart_with_one_product(product_name)
    cart = Cart.create
    product = products(product_name)
    cart.add_product(product.id, product.price).save!
    cart
  end

  test 'cart should create a new line item when adding a new product' do
    cart = new_cart_with_one_product(:one)
    assert_equal 1, cart.line_items.length
    #Add a new product
    product = products(:two);
    cart.add_product(product.id, product.price).save!
    assert_equal 2, cart.line_items.length
  end

  test 'cart should update an existing line item when adding an existing product' do
    cart = new_cart_with_one_product(:one)
    cart.line_items.each do |i|
      puts i.product.id
    end
    # Re-add the same product
    product = products(:one);
    cart.add_product(product.id, product.price).save!
    cart.line_items.each do |i|
      puts i.product.id
    end
    assert_equal 1, cart.line_items.length
  end
end
