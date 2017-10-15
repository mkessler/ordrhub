Rails.application.routes.draw do
  devise_for :users

  resources :organizations do
    resources :restaurants, only: :index
  end
  resources :restaurants, except: :index do
    resources :orders, except: [:new, :edit]
  end

  get 'home/index'
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
