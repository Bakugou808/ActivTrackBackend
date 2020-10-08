Rails.application.routes.draw do
  # resources :users
  resources :users, only: %i[create show update destroy]

  post '/login', to: 'auth#create'
  get '/authorize', to: 'auth#show'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # resources :movies
    end
  end

end
