Rails.application.routes.draw do
  devise_for :users

  resources :organizations do
    resources :stores, only: :index
  end
  resources :stores, except: :index do
    resources :orders, except: [:new, :edit]
  end

  get 'home/index'
  get 'dashboard/index'

  authenticated :user do
    root to: redirect('/dashboard/index'), as: :authenticated_root
  end
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
