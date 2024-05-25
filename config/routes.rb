Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :posts, only: %i[index create]
  resources :users, only: %i[index create show update]
  post '/auth/login', to: 'authentication#login'
end
