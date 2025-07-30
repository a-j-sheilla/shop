# ProductsHelper
#
# Helper methods for product-related views and functionality.
# Provides utility methods for displaying product information and
# managing user permissions for product operations.
#
# Used in:
# - Product index and show views
# - Product listing displays
# - Edit/delete permission checks
#
module ProductsHelper

  # Display the seller/author information for a product
  # Shows the user's name if available, falls back to email, or shows default text
  #
  # @param product [Product] The product to get author information for
  # @return [String] The display name for the product's seller
  #
  # Priority order:
  # 1. User's name (if present and not blank)
  # 2. User's email (if user exists but no name)
  # 3. "Unknown Seller" (if no user associated)
  #
  # Example usage in views:
  #   <p>Sold by: <%= product_author(@product) %></p>
  #
  # Example outputs:
  #   "John Smith"           # When user has name
  #   "john@example.com"     # When user exists but no name
  #   "Unknown Seller"       # When no user associated
  def product_author(product)
    if product.user
      # User exists, prefer name over email
      product.user.name.present? ? product.user.name : product.user.email
    else
      # No user associated with this product
      "Unknown Seller"
    end
  end

  # Check if the current user can edit/delete a specific product
  # Only the product owner should be able to modify their products
  #
  # @param product [Product] The product to check permissions for
  # @return [Boolean] true if current user can edit the product, false otherwise
  #
  # Requirements for editing:
  # 1. User must be signed in (authenticated)
  # 2. Current user must be the owner of the product
  #
  # Example usage in views:
  #   <% if can_edit_product?(@product) %>
  #     <%= link_to 'Edit', edit_product_path(@product) %>
  #     <%= link_to 'Delete', product_path(@product), method: :delete %>
  #   <% end %>
  #
  # Security note:
  # This helper provides UI-level permission checking.
  # Controllers must also implement server-side authorization checks.
  def can_edit_product?(product)
    user_signed_in? && current_user == product.user
  end
end
