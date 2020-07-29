Rails.application.routes.draw do

  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/health', to: 'health#health'
  resources :phrases, only: [:index, :show, :create, :update, :destroy]
  resources :lessons, only: [:index, :show, :create, :update, :destroy]
  resources :courses, only: [:index, :show, :create, :edit, :update, :destroy]
  resources :userscourses, only: [:create, :destroy],param: :course_id
  resources :phonetics, only: [:index, :show]
  # Routes for Google authentication
  # [START login]
  # get "/login", to: redirect("/auth/google_oauth2")
  # [END login]

  # [START sessions]
  # get "/auth/google_oauth2/callback", to: "sessions#create"

  # resource :session, only: [:create, :destroy]
  # [END sessions]

  # [START logout]
  #get "/logout", to: "sessions#destroy"
  # [END logout]
  root 'courses#index'
  delete "/logout", to: "sessions#logout"
  get "/get_user", to: "sessions#get_user"
  get "/redirect", to: "sessions#redirect"
  get "/fresh-token/:uid", to: "sessions#fresh_token"
  resources :sessions, only: :index
  get "/auth/:provider/callback" => 'sessions#create'
end
