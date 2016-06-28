Rails.application.routes.draw do
  devise_for :users, :skip => [:sessions]
  as :user do
    get 'sign_in' => 'home#index', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  get '/auth/spotify/callback', to: 'users/omniauth_callbacks#spotify'

  resources :mixtapes, only: [:index, :show, :create, :destroy] do
    get :contribute, on: :member
  end

  get 'console', to: 'home#console' if Rails.env.development?

  root 'home#index'
end
