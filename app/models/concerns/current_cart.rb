module CurrentCart
  private

  def set_cart
    @cart = Cart.find(session[:cart_id]) if session[:cart_id]
    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
    @cart
  end

  def current_cart
    @cart ||= set_cart
  end
end
