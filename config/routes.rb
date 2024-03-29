# Our routes configuration
Rails.application.routes.draw do
  # This is used by default with devise
  devise_for :users
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  # Adding and creating new invitation route
  resources :invitations, only: [:new, :create]
  # getting users scores route
  resources :users, only: [:import, :new_import] do
    collection do
      get 'new_import'
      post 'import'
    end
  end
  # Root app to dashboard controller action index
  root to: 'dashboard#index'
end
