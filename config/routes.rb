Rails.application.routes.draw do
  resources :posts, only: %i[index create]
  resources :users, only: %i[index create show update]
  post '/auth/login', to: 'authentication#login'
end
