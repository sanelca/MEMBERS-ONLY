Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/signup'  => 'users#new'
  post '/signup'  => 'users#create'
  resources :users
  get  '/login'   => 'sessions#new'
  post '/login'   => 'sessions#create'
  delete '/logout'=> 'sessions#destroy'
  resources :posts
end
