# ProductsController
#
# Handles all CRUD operations for products in the e-commerce application.
# Provides both HTML and JSON responses for API compatibility.
# Implements user authentication and authorization for product management.
#
# Routes:
# - GET    /products           => index (list all products)
# - GET    /products/:id       => show (display single product)
# - GET    /products/new       => new (new product form)
# - POST   /products           => create (create new product)
# - GET    /products/:id/edit  => edit (edit product form)
# - PATCH  /products/:id       => update (update existing product)
# - DELETE /products/:id       => destroy (delete product)
#
# Authentication:
# - Anonymous users can view products (index, show)
# - Authenticated users can create products
# - Only product owners can edit/update/delete their products
#
# Key Features:
# - User ownership validation for all modification operations
# - Image upload support via CarrierWave
# - Comprehensive error handling and user feedback
# - JSON API support for all actions
#
class ProductsController < ApplicationController

  # === BEFORE ACTIONS ===

  # Load the product for actions that need it
  # Reduces code duplication and ensures consistent product loading
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  # Require user authentication for create/edit/delete operations
  # Anonymous users can still browse products (index, show)
  before_action :authenticate_user!, except: [:index, :show]

  # === PUBLIC ACTIONS ===

  # Display all products in the shop
  # Shows products in reverse chronological order (newest first)
  #
  # GET /products
  # GET /products.json
  #
  # Instance Variables:
  # @products - All products ordered by creation date (newest first)
  def index
    @products = Product.all.order("created_at desc")
  end

  # Display a single product with full details
  # Available to all users (no authentication required)
  #
  # GET /products/:id
  # GET /products/:id.json
  #
  # Instance Variables:
  # @products - The specific product to display (note: should be @product for consistency)
  def show
    @products = Product.find(params[:id])
  end

  # Custom method for direct database access (currently unused)
  # This method bypasses ActiveRecord for raw SQL queries
  # Consider removing if not needed, or move to private section
  #
  # @param id [Integer] Product ID to find
  # @return [Hash] Raw database row as hash
  def find_product_by_id(id)
    connection.execute("SELECT * FROM products WHERE products.id = ? LIMIT 1", id).first
  end

  # Display form for creating a new product
  # Only available to authenticated users
  #
  # GET /products/new
  #
  # Instance Variables:
  # @product - New product instance associated with current user
  def new
    @product = current_user.products.build
  end

  # Display form for editing an existing product
  # Only available to the product owner
  #
  # GET /products/:id/edit
  #
  # Authorization: Redirects if user doesn't own the product
  def edit
    unless @product.user == current_user
      redirect_to shop_path, alert: "You can only edit your own products."
    end
  end

  # Create a new product
  # Associates the product with the current user and handles validation
  #
  # POST /products
  # POST /products.json
  #
  # Parameters: product_params (see private method)
  # Redirects to product page on success, renders form on failure
  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created. Your product is now live!" }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update an existing product
  # Only allows updates by the product owner
  #
  # PATCH /products/:id
  # PUT /products/:id
  # PATCH /products/:id.json
  # PUT /products/:id.json
  #
  # Parameters: product_params (see private method)
  # Authorization: Redirects if user doesn't own the product
  def update
    unless @product.user == current_user
      redirect_to shop_path, alert: "You can only update your own products."
      return
    end

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # Delete an existing product
  # Only allows deletion by the product owner
  # Note: Products in active carts are protected by model callback
  #
  # DELETE /products/:id
  # DELETE /products/:id.json
  #
  # Authorization: Only product owner can delete
  # Protection: Model prevents deletion if product is in any cart
  def destroy
    if @product.user == current_user

      # Note: The following cart check is commented out because
      # the Product model handles this protection via before_destroy callback
      # This provides better error handling and user feedback
      # if @product.cart_items.exists?
      #   redirect_to shop_path, alert: "This product is in someone's cart and can't be deleted." and return
      # end

      @product.destroy
      respond_to do |format|
        format.html { redirect_to shop_path, notice: "Product was successfully deleted." }
        format.json { head :no_content }
      end
    else
      redirect_to shop_path, alert: "You can only delete your own products."
    end
  end

  private

  # === PRIVATE METHODS ===

  # Load the product for actions that need it
  # Used by before_action to set @product for show, edit, update, destroy
  #
  # @raises [ActiveRecord::RecordNotFound] If product doesn't exist
  def set_product
    @product = Product.find(params[:id])
  end

  # Strong parameters for product creation and updates
  # Defines which parameters are allowed from the form submission
  # Prevents mass assignment vulnerabilities
  #
  # @return [ActionController::Parameters] Permitted parameters
  def product_params
    params.require(:product).permit(:brand, :model, :description, :condition, :finish, :title, :price, :image)
  end
end
