# CartsController
#
# Handles all shopping cart related operations including viewing cart contents,
# adding/removing items, updating quantities, and emptying the cart.
# Provides comprehensive error handling and user feedback for all operations.
#
# Routes:
# - GET    /carts/:id           => show (display cart contents)
# - POST   /cart/add_item/:id   => add_item (add product to cart)
# - DELETE /cart/remove_item/:id => remove_item (remove item from cart)
# - PATCH  /cart/update_quantity/:id => update_quantity (change item quantity)
# - DELETE /carts/:id/empty_cart => empty_cart (clear all items)
#
# Key Features:
# - Session-based cart persistence
# - Comprehensive error handling with user-friendly messages
# - Optimized database queries with includes
# - Graceful handling of edge cases (missing products, invalid quantities)
#
class CartsController < ApplicationController

  # === INCLUDES ===

  # Include CurrentCart concern for cart management functionality
  # This provides access to current_cart method and cart persistence
  include CurrentCart

  # === BEFORE ACTIONS ===

  # Ensure cart is set up for actions that need it
  # Only needed for show and empty_cart as other actions use current_cart directly
  before_action :set_cart, only: [:show, :empty_cart]

  # === PUBLIC ACTIONS ===

  # Display the contents of the shopping cart
  # Shows all cart items with their associated products and quantities
  #
  # GET /carts/:id
  #
  # Instance Variables:
  # @cart_items - Collection of cart items with preloaded products (for performance)
  def show
    # Use includes to avoid N+1 queries when displaying product information
    @cart_items = @cart.cart_items.includes(:product)
  end

  # Add a product to the shopping cart
  # Handles both new additions and quantity increments for existing items
  #
  # POST /cart/add_item/:product_id
  #
  # Parameters:
  # - product_id: ID of the product to add to cart
  #
  # Redirects back to referring page with success/error message
  def add_item
    begin
      # Find the product to add to cart
      product = Product.find(params[:product_id])

      # Add product to cart (creates new item or increments existing quantity)
      @cart_item = current_cart.add_product(product)

      # Save the cart item and provide user feedback
      if @cart_item.save
        redirect_to request.referer || shop_path, notice: 'Added to your cart'
      else
        # Handle validation errors
        redirect_to request.referer || shop_path, alert: "Unable to add item to cart: #{@cart_item.errors.full_messages.join(', ')}"
      end
    rescue ActiveRecord::RecordNotFound
      # Handle case where product doesn't exist
      redirect_to shop_path, alert: 'Product not found'
    rescue => e
      # Handle any other unexpected errors
      redirect_to request.referer || shop_path, alert: "Error adding to cart: #{e.message}"
    end
  end

  # Remove a specific item from the shopping cart
  # Completely removes the cart item (all quantities of that product)
  #
  # DELETE /cart/remove_item/:id
  #
  # Parameters:
  # - id: ID of the cart_item to remove
  #
  # Redirects to cart page with success/error message
  def remove_item
    begin
      # Find the cart item within the current cart (security check)
      @cart_item = current_cart.cart_items.find(params[:id])

      # Remove the item completely
      @cart_item.destroy
      redirect_to cart_path(current_cart), notice: 'Removed from your cart'
    rescue ActiveRecord::RecordNotFound
      # Handle case where cart item doesn't exist or doesn't belong to current cart
      redirect_to cart_path(current_cart), alert: 'Item not found in cart'
    rescue => e
      # Handle any other unexpected errors
      redirect_to cart_path(current_cart), alert: "Error removing item: #{e.message}"
    end
  end

  # Empty the entire shopping cart
  # Removes all items from the cart and redirects to shop
  #
  # DELETE /carts/:id/empty_cart
  #
  # Redirects to shop page with success/error message
  def empty_cart
    begin
      # Remove all items from the cart
      current_cart.empty_cart
      redirect_to shop_path, notice: 'Cart emptied successfully'
    rescue => e
      # Handle any unexpected errors
      redirect_to cart_path(current_cart), alert: "Error emptying cart: #{e.message}"
    end
  end

  # Update the quantity of a specific cart item
  # Can increase, decrease, or remove items based on new quantity
  #
  # PATCH /cart/update_quantity/:id
  #
  # Parameters:
  # - id: ID of the cart_item to update
  # - quantity: New quantity (if 0 or negative, item is removed)
  #
  # Redirects to cart page with success/error message
  def update_quantity
    begin
      # Find the cart item within the current cart
      @cart_item = current_cart.cart_items.find(params[:id])
      new_quantity = params[:quantity].to_i

      if new_quantity > 0
        # Update quantity if positive
        if @cart_item.update(quantity: new_quantity)
          redirect_to cart_path(current_cart), notice: 'Quantity updated'
        else
          # Handle validation errors
          redirect_to cart_path(current_cart), alert: "Error updating quantity: #{@cart_item.errors.full_messages.join(', ')}"
        end
      else
        # Remove item if quantity is 0 or negative
        @cart_item.destroy
        redirect_to cart_path(current_cart), notice: 'Item removed from cart'
      end
    rescue ActiveRecord::RecordNotFound
      # Handle case where cart item doesn't exist
      redirect_to cart_path(current_cart), alert: 'Item not found in cart'
    rescue => e
      # Handle any other unexpected errors
      redirect_to cart_path(current_cart), alert: "Error updating quantity: #{e.message}"
    end
  end

  private

  # Private methods would go here if needed
  # Currently all cart functionality is handled by the CurrentCart concern
end
