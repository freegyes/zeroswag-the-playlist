Rails.application.routes.draw do
  devise_for :users

  get '/auth/spotify/callback', to: 'users/omniauth_callbacks#spotify'

  resources :events, only: [:index, :new, :create]

  get 'console', to: 'home#console' if Rails.env.development?

  root 'home#index'
end
