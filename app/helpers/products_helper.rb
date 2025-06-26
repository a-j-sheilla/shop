module ProductsHelper
  def product_author(product)
    if product.user
      product.user.name.present? ? product.user.name : product.user.email
    else
      "Unknown Seller"
    end
  end

  def can_edit_product?(product)
    user_signed_in? && current_user == product.user
  end
end
