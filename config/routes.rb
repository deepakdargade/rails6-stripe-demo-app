Rails.application.routes.draw do
  devise_for :users
  resources :products
  resources :webhooks, only: [:create]
  root 'products#index'
  post 'checkout/create', to: 'checkout#create'
  get 'success', to: 'checkout#success'
  get 'cancel', to: 'checkout#cancel'

  post "products/add_to_cart/:id" => "products#add_to_cart", as: 'add_to_cart'
  delete "products/remove_from_cart/:id" => "products#remove_from_cart", as: 'remove_from_cart'
end
