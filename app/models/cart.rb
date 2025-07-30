# Cart Model
#
# Represents a shopping cart that can contain multiple products.
# Carts are session-based and persist across user authentication states.
# Each cart contains cart_items which link to products with quantities.
#
# Database Table: carts
# Primary Key: id
#
# Key Features:
# - Session-based persistence (managed by CurrentCart concern)
# - Multiple products with quantities through cart_items
# - Automatic total price and item count calculations
# - Add/remove product functionality
# - Complete cart clearing capability
#
# Usage:
#   cart = Cart.create
#   cart.add_product(product)
#   cart.total_price  # => calculated total
#   cart.total_items  # => total quantity of all items
#
class Cart < ApplicationRecord

  # === ASSOCIATIONS ===

  # Cart contains multiple cart items (individual product entries with quantities)
  # dependent: :destroy ensures all cart items are removed when cart is deleted
  has_many :cart_items, dependent: :destroy

  # Access products directly through cart_items association
  # This provides a convenient way to get all products in the cart
  has_many :products, through: :cart_items

  # === INSTANCE METHODS ===

  # Add a product to the cart or increment quantity if already present
  # This method handles both new additions and quantity updates intelligently
  #
  # @param product [Product] The product to add to the cart
  # @return [CartItem] The cart item that was created or updated
  #
  # Example:
  #   cart.add_product(product)  # Adds product with quantity 1
  #   cart.add_product(product)  # Increments quantity to 2
  def add_product(product)
    # Check if product is already in cart
    current_item = cart_items.find_by(product: product)

    if current_item
      # Product exists, increment quantity
      current_item.quantity += 1
      current_item.save
    else
      # New product, create cart item with quantity 1
      current_item = cart_items.build(product: product, quantity: 1)
    end

    current_item
  end

  # Calculate the total price of all items in the cart
  # Multiplies each item's quantity by its product price and sums the results
  #
  # @return [BigDecimal] Total price of all cart items
  #
  # Example:
  #   cart.total_price  # => 149.99
  def total_price
    cart_items.sum { |item| item.quantity * item.product.price }
  end

  # Calculate the total number of items in the cart
  # Sums the quantities of all cart items
  #
  # @return [Integer] Total quantity of all items in cart
  #
  # Example:
  #   cart.total_items  # => 5 (could be 3 of one product + 2 of another)
  def total_items
    cart_items.sum(:quantity)
  end

  # Remove all items from the cart
  # This completely empties the cart by destroying all cart_items
  #
  # @return [void]
  #
  # Example:
  #   cart.empty_cart  # Cart is now empty
  def empty_cart
    cart_items.destroy_all
  end
end
