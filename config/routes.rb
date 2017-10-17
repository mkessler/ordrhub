Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]

  resources :organizations do
    get :stores
  end
  resources :stores, except: [:show] do
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
