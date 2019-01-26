Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  resources :invitations, only: [:new, :create]
  root to: 'dashboard#index'
end
