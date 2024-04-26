Rails.application.routes.draw do
  resources :users, only: %i[index create] do
    resources :posts, only: %i[index create]
  end
end
