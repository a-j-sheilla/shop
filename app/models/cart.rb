class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product)
    current_item = cart_items.find_by(product: product)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(product: product)
    end
    current_item
  end

  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end

  def total_items
    cart_items.sum(:quantity)
  end

  def empty_cart
    cart_items.destroy_all
  end
end
