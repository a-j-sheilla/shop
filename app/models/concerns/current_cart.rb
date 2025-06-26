module CurrentCart
  private

  def set_cart
    if session[:cart_id]
      begin
        @cart = Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
        session[:cart_id] = nil
        @cart = nil
      end
    end

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
