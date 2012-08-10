require 'sidekiq/web'

VegastechApp::Application.routes.draw do
  get 'sessions/create'

  resources :posts do
    resources :votes
  end

  resources :stories do
    resources :votes
    resources :comments
  end

  resources :sessions, only: [:create, :destroy]

  mount Sidekiq::Web, at: '/sidekiq'

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/sign_out', to: 'sessions#destroy'
  match '/recent', to: 'info#recent', as: :recent
  match '/supporters', to: 'info#users', as: :users
  match '/best_of_week/', to: 'info#best_of_week', as: :best_of_week

  root to: 'stories#index'
end
