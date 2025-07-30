# ApplicationController
#
# Base controller for the e-commerce application.
# All other controllers inherit from this class, providing shared functionality
# and configuration that applies to the entire application.
#
# Key Responsibilities:
# - CSRF protection for security
# - Shopping cart management for all requests
# - Custom redirect paths after authentication
# - Shared before_actions and helper methods
#
# Included Concerns:
# - CurrentCart: Provides session-based cart management
#
class ApplicationController < ActionController::Base

    # === INCLUDES ===

    # Include CurrentCart concern to provide cart functionality
    # This makes cart management available to all controllers
    include CurrentCart

    # === SECURITY ===

    # Enable CSRF (Cross-Site Request Forgery) protection
    # This prevents malicious sites from making unauthorized requests
    # Uses exception strategy to raise error on invalid tokens
    protect_from_forgery with: :exception

    # === BEFORE ACTIONS ===

    # Set up the shopping cart for every request
    # This ensures @cart is available in all controller actions
    # Cart persists across authenticated and guest sessions
    before_action :set_cart

    # === DEVISE CUSTOMIZATION ===

    # Custom redirect path after successful user login
    # Redirects users to the shop page instead of default root
    #
    # @param resource [User] The authenticated user (not used in this implementation)
    # @return [String] Path to redirect to after login
    def after_sign_in_path_for(resource)
      shop_path
    end

    # Custom redirect path after user logout
    # Redirects users to the shop page to continue browsing
    #
    # @param resource_or_scope [User|Symbol] The logged out user or scope (not used)
    # @return [String] Path to redirect to after logout
    def after_sign_out_path_for(resource_or_scope)
      shop_path
    end
end
