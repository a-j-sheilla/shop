# Routes Configuration
#
# Defines all URL routes for the Shop e-commerce application.
# Maps URLs to controller actions and provides named route helpers.
#
# Route Structure:
# - Root and landing pages
# - User authentication (Devise)
# - Product management (CRUD)
# - Shopping cart functionality
#
# For details on the DSL available within this file, see:
# https://guides.rubyonrails.org/routing.html
#
Rails.application.routes.draw do

  # === PRODUCT ROUTES ===
  # Full RESTful routes for product management
  # Generates: index, show, new, create, edit, update, destroy
  #
  # Routes generated:
  # GET    /products           => products#index
  # GET    /products/new       => products#new
  # POST   /products           => products#create
  # GET    /products/:id       => products#show
  # GET    /products/:id/edit  => products#edit
  # PATCH  /products/:id       => products#update
  # DELETE /products/:id       => products#destroy
  resources :products

  # === USER AUTHENTICATION ROUTES (DEVISE) ===
  # Devise routes for user authentication with custom registration controller
  # Uses custom RegistrationsController to handle additional user attributes
  #
  # Routes generated:
  # GET    /users/sign_in      => devise/sessions#new
  # POST   /users/sign_in      => devise/sessions#create
  # DELETE /users/sign_out     => devise/sessions#destroy
  # GET    /users/sign_up      => registrations#new
  # POST   /users              => registrations#create
  # GET    /users/edit         => registrations#edit
  # PATCH  /users              => registrations#update
  devise_for :users, controllers: {
    registrations: 'registrations'  # Use custom registrations controller
  }

  # === SHOP ALIAS ROUTE ===
  # Friendly URL alias for the product index page
  # Provides a more intuitive URL for browsing products
  #
  # Route: GET /shop => products#index
  # Helper: shop_path, shop_url
  get 'shop', to: 'products#index', as: 'shop'

  # === SHOPPING CART ROUTES ===
  # Limited cart resource with custom member actions
  # Only provides show action plus custom empty_cart action
  #
  # Routes generated:
  # GET    /carts/:id          => carts#show
  # DELETE /carts/:id/empty_cart => carts#empty_cart
  resources :carts, only: [:show] do
    member do
      delete :empty_cart  # Custom action to clear all cart items
    end
  end

  # === CART ITEM MANAGEMENT ROUTES ===
  # Custom routes for managing individual cart items
  # These routes handle adding, removing, and updating cart contents

  # Add a product to the cart
  # Route: POST /cart/add_item/:product_id => carts#add_item
  # Helper: add_to_cart_path(product), add_to_cart_url(product)
  # Usage: <%= link_to "Add to Cart", add_to_cart_path(product), method: :post %>
  post 'cart/add_item/:product_id', to: 'carts#add_item', as: 'add_to_cart'

  # Remove a specific cart item
  # Route: DELETE /cart/remove_item/:id => carts#remove_item
  # Helper: remove_from_cart_path(cart_item), remove_from_cart_url(cart_item)
  # Usage: <%= link_to "Remove", remove_from_cart_path(cart_item), method: :delete %>
  delete 'cart/remove_item/:id', to: 'carts#remove_item', as: 'remove_from_cart'

  # Update quantity of a cart item
  # Route: PATCH /cart/update_quantity/:id => carts#update_quantity
  # Helper: update_cart_quantity_path(cart_item), update_cart_quantity_url(cart_item)
  # Usage: Used with AJAX forms for quantity updates
  patch 'cart/update_quantity/:id', to: 'carts#update_quantity', as: 'update_cart_quantity'

  # === ROOT ROUTE ===
  # Application landing page
  # Directs users to store controller which handles authentication-based routing
  #
  # Route: GET / => store#index
  # Helper: root_path, root_url
  root 'store#index'
end
