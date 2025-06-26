class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show, :destroy]
  before_action :set_cart_item, only: [:add_item, :remove_item, :update_quantity]

  def show
    @cart_items = @cart.cart_items.includes(:product)
  end

  def add_item
    product = Product.find(params[:product_id])
    @cart_item = current_cart.add_product(product)

    if @cart_item.save
      redirect_to request.referer || shop_path, notice: 'Added to your cart'
    else
      redirect_to request.referer || shop_path, alert: 'Unable to add item to cart'
    end
  end

  def remove_item
    @cart_item = current_cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(current_cart), notice: 'Removed from your cart'
  end

  def empty_cart
    current_cart.empty_cart
    redirect_to shop_path, notice: 'Cart emptied successfully'
  end

  def update_quantity
    @cart_item = current_cart.cart_items.find(params[:id])
    new_quantity = params[:quantity].to_i

    if new_quantity > 0
      @cart_item.update(quantity: new_quantity)
      redirect_to cart_path(current_cart), notice: 'Quantity updated'
    else
      @cart_item.destroy
      redirect_to cart_path(current_cart), notice: 'Item removed from cart'
    end
  end

  private

  def set_cart_item
    @cart_item = current_cart.cart_items.find_by(id: params[:id])
  end
end
