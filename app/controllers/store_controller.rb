class StoreController < ApplicationController
  def index
    if user_signed_in?
      @products = Product.all
      render 'products/index'
    else
      redirect_to new_user_session_path
    end
  end
end
