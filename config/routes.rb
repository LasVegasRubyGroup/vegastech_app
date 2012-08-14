require 'sidekiq/web'

VegastechApp::Application.routes.draw do
  admin_constraint = lambda do |request|
    if user_id = request.session['user_id']
      User.find(user_id).admin?
    end
  end

  constraints admin_constraint do
    mount Sidekiq::Web, at: '/sidekiq'
  end

  get 'sessions/create'

  resources :posts do
    resources :votes
  end

  resources :photos do
    resources :votes
    resources :comments
  end

  resources :stories do
    resources :votes
    resources :comments
  end

  resources :sessions, only: [:create, :destroy]

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/sign_out', to: 'sessions#destroy'
  match '/recent', to: 'info#recent', as: :recent
  match '/supporters', to: 'info#users', as: :users
  match '/best_of_week/', to: 'info#best_of_week', as: :best_of_week

  root to: 'stories#index'
end
