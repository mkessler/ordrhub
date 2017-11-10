Rails.application.routes.draw do
  resources :leads
  devise_for :users

  resources :organizations
  resources :stores do
    post :incoming_order, on: :collection
    resources :orders, except: [:new, :edit]
  end

  get 'dashboard/index'
  get 'marketing/index'
  get 'privacy_policy', to: "marketing#privacy_policy"
  post 'zapier/incoming_grubhub_order'

  authenticated :user do
    root to: redirect('/dashboard/index'), as: :authenticated_root
  end
  root to: "marketing#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
