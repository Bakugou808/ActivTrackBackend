Rails.application.routes.draw do

  # resources :users
  resources :users, only: %i[create show update destroy]

  post '/login', to: 'auth#create'
  get '/authorize', to: 'auth#show'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # resources :movies  
      resources :circuit_exercise_session_details, only: %i[create show update destroy]
      resources :sessions, only: %i[create show update destroy]
      resources :circuit_exercises, only: %i[create show update destroy]
      resources :workout_circuits, only: %i[create update destroy]
      resources :exercises
      resources :circuits, only: %i[create update destroy]
      resources :workouts
      resources :folders
      get '/folders/user/:user_id', to: 'folders#users_folders'
    end
  end

end
