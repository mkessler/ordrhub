Rails.application.routes.draw do
  devise_for :users

  resources :organizations
  resources :stores, except: [:show] do
    resources :orders, except: [:new, :edit]
  end

  get 'home/index'
  get 'dashboard/index'
  get 'marketing/index'

  authenticated :user do
    root to: redirect('/dashboard/index'), as: :authenticated_root
  end
  root to: "marketing#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
