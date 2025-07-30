# CartItem Model
#
# Represents an individual item within a shopping cart.
# Acts as a join table between Cart and Product with additional quantity information.
# Each cart item links a specific product to a cart with a specified quantity.
#
# Database Table: cart_items
# Primary Key: id
# Foreign Keys: cart_id (references carts), product_id (references products)
#
# Key Features:
# - Links carts and products in a many-to-many relationship
# - Stores quantity for each product in the cart
# - Calculates total price for the specific item (quantity × product price)
# - Validates quantity to ensure positive values
#
# Usage:
#   cart_item = CartItem.create(cart: cart, product: product, quantity: 2)
#   cart_item.total_price  # => quantity * product.price
#
class CartItem < ApplicationRecord

  # === ASSOCIATIONS ===

  # Each cart item belongs to exactly one cart
  # This association is required (cart_item cannot exist without a cart)
  belongs_to :cart

  # Each cart item belongs to exactly one product
  # This association is required (cart_item cannot exist without a product)
  belongs_to :product

  # === VALIDATIONS ===

  # Quantity must be present and greater than 0
  # This ensures that cart items always have a valid, positive quantity
  # Prevents invalid states like 0 or negative quantities
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  # === INSTANCE METHODS ===

  # Calculate the total price for this cart item
  # Multiplies the quantity by the product's unit price
  #
  # @return [BigDecimal] Total price for this cart item (quantity × product price)
  #
  # Example:
  #   cart_item.quantity = 3
  #   cart_item.product.price = 29.99
  #   cart_item.total_price  # => 89.97
  def total_price
    quantity * product.price
  end
end
