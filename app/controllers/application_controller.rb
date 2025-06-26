class ApplicationController < ActionController::Base
    include CurrentCart
    protect_from_forgery with: :exception
    before_action :set_cart

    # Redirect to shop after login
    def after_sign_in_path_for(resource)
      shop_path
    end

    # Redirect to login after logout
    def after_sign_out_path_for(resource_or_scope)
      root_path
    end
end
