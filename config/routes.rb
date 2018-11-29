Rails.application.routes.draw do
  root 'posts#index'
  get 'posts/index'
  get '/posts', to: 'posts#index'
  get 'posts/show'
  get 'posts/new'
  get 'posts/edit'
  get 'posts/create'
  get 'posts/update'
  get 'posts/destroy'
  get 'sessions/new'
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  resources :users do
    resources :posts
  end
end
