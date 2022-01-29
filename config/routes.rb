Rails.application.routes.draw do
  devise_for :users
  resources :products
  resources :webhooks, only: [:create]
  root 'products#index'
  post 'checkout/create', to: 'checkout#create'
  get 'success', to: 'checkout#success'
  get 'cancel', to: 'checkout#cancel'
end
