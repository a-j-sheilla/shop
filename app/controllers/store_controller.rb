# StoreController
#
# Handles the main store/landing page functionality.
# Acts as the entry point for the application and manages access control.
# Redirects users to appropriate pages based on authentication status.
#
# Routes:
# - GET / (root) => index (main landing page)
#
# Key Features:
# - Authentication-based routing
# - Redirects authenticated users to product listings
# - Redirects unauthenticated users to login page
# - Reuses existing product index view for consistency
#
class StoreController < ApplicationController

  # Main landing page for the application
  # Handles different user states and redirects accordingly
  #
  # GET /
  #
  # Behavior:
  # - Authenticated users: See all products (reuses products/index view)
  # - Unauthenticated users: Redirected to login page
  #
  # Instance Variables (when authenticated):
  # @products - All products in the system
  def index
    if user_signed_in?
      # User is authenticated, show them the product catalog
      @products = Product.all
      # Reuse the products index view for consistency
      render 'products/index'
    else
      # User is not authenticated, redirect to login
      redirect_to new_user_session_path
    end
  end
end
