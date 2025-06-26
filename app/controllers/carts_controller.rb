class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show, :empty_cart]

  def show
    @cart_items = @cart.cart_items.includes(:product)
  end

  def add_item
    begin
      product = Product.find(params[:product_id])
      @cart_item = current_cart.add_product(product)

      if @cart_item.save
        redirect_to request.referer || shop_path, notice: 'Added to your cart'
      else
        redirect_to request.referer || shop_path, alert: "Unable to add item to cart: #{@cart_item.errors.full_messages.join(', ')}"
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to shop_path, alert: 'Product not found'
    rescue => e
      redirect_to request.referer || shop_path, alert: "Error adding to cart: #{e.message}"
    end
  end

  def remove_item
    begin
      @cart_item = current_cart.cart_items.find(params[:id])
      @cart_item.destroy
      redirect_to cart_path(current_cart), notice: 'Removed from your cart'
    rescue ActiveRecord::RecordNotFound
      redirect_to cart_path(current_cart), alert: 'Item not found in cart'
    rescue => e
      redirect_to cart_path(current_cart), alert: "Error removing item: #{e.message}"
    end
  end

  def empty_cart
    begin
      current_cart.empty_cart
      redirect_to shop_path, notice: 'Cart emptied successfully'
    rescue => e
      redirect_to cart_path(current_cart), alert: "Error emptying cart: #{e.message}"
    end
  end

  def update_quantity
    begin
      @cart_item = current_cart.cart_items.find(params[:id])
      new_quantity = params[:quantity].to_i

      if new_quantity > 0
        if @cart_item.update(quantity: new_quantity)
          redirect_to cart_path(current_cart), notice: 'Quantity updated'
        else
          redirect_to cart_path(current_cart), alert: "Error updating quantity: #{@cart_item.errors.full_messages.join(', ')}"
        end
      else
        @cart_item.destroy
        redirect_to cart_path(current_cart), notice: 'Item removed from cart'
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to cart_path(current_cart), alert: 'Item not found in cart'
    rescue => e
      redirect_to cart_path(current_cart), alert: "Error updating quantity: #{e.message}"
    end
  end

  private
end
