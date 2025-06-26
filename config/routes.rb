Rails.application.routes.draw do
  resources :products
  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  resources :carts, only: [:show] do
    member do
      delete :empty_cart
    end
  end

  post 'cart/add_item/:product_id', to: 'carts#add_item', as: 'add_to_cart'
  delete 'cart/remove_item/:id', to: 'carts#remove_item', as: 'remove_from_cart'

  root 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
