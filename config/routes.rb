Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'articles#index'
  resources :articles do
    resource :like, only: [:show, :create, :destroy]
    resources :comments, only: [:index, :create]
  end
  resources :accounts, only: [:show] do
    resource :follow, only: [:create]
    resource :unfollow, only: [:create]
  end
  resource :timeline, only: [:show]
  resource :profile, only: [:show, :edit, :update]
end
