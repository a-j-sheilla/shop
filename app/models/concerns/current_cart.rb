# CurrentCart Concern
#
# Provides session-based shopping cart management functionality.
# This concern can be included in controllers to provide cart persistence
# across user sessions, whether authenticated or not.
#
# Key Features:
# - Session-based cart persistence using session[:cart_id]
# - Automatic cart creation when needed
# - Cart recovery and cleanup for invalid/deleted carts
# - Works for both authenticated and guest users
# - Memoization for performance (cart loaded once per request)
#
# Usage:
#   class ApplicationController < ActionController::Base
#     include CurrentCart
#     before_action :set_cart
#   end
#
# The cart persists across:
# - Page refreshes and navigation
# - User login/logout cycles
# - Browser sessions (until session expires)
#
module CurrentCart
  private

  # Set up the current cart for the session
  # This method handles cart retrieval, creation, and cleanup
  # Called automatically by controllers that include this concern
  #
  # @return [Cart] The current cart instance
  #
  # Process:
  # 1. Check if session has a cart_id
  # 2. Try to find the cart in database
  # 3. Handle case where cart was deleted (cleanup session)
  # 4. Create new cart if none exists
  # 5. Store cart_id in session for future requests
  def set_cart
    # Check if we have a cart_id stored in the session
    if session[:cart_id]
      begin
        # Try to find the cart in the database
        @cart = Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
        # Cart was deleted from database, clean up session
        session[:cart_id] = nil
        @cart = nil
      end
    end

    # Create a new cart if we don't have one
    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end

    @cart
  end

  # Get the current cart with memoization
  # This method provides a convenient way to access the cart
  # and ensures the cart is only loaded once per request
  #
  # @return [Cart] The current cart instance
  #
  # Example usage in controllers:
  #   def add_to_cart
  #     current_cart.add_product(product)
  #   end
  def current_cart
    @cart ||= set_cart
  end
end
