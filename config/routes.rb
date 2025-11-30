Rails.application.routes.draw do
  # Home page
  root "products#index"

  # Devise authentication
  devise_for :users

  # Products
  resources :products

  # Categories (for breadcrumbs + admin)
  resources :categories, only: [:index, :show]

  # Cart
  get  "cart",        to: "carts#show",  as: :cart
  post "cart/add/:id", to: "carts#add",  as: :add_cart
  post "cart/remove/:id", to: "carts#remove", as: :remove_cart
  post "cart/clear",       to: "carts#clear",  as: :clear_cart

  # Orders
  resources :orders, only: [:index, :show]

  # Checkout (this fixes your error)
  get  "checkout", to: "checkout#new",    as: :checkout
  post "checkout", to: "checkout#create"

  # ActiveAdmin
  ActiveAdmin.routes(self)
end
