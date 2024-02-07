Rails.application.routes.draw do
  devise_for :users, path: 'auth',
  path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'signup' }
  devise_scope :user do
    get '/auth/logout', to: 'devise/sessions#destroy'
    root to: 'devise/sessions#new'
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :create, :new, :show] 
  end
  
  resources :posts, only: [:index, :create, :new, :show] do
    resources :comments, only: [:create, :new]
    resources :likes, only: [:create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
