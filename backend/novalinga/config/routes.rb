Rails.application.routes.draw do
  get 'userscourses/index'
  get 'userscourses/create'
  get 'userscourses/show'
  get 'userscourses/update'
  get 'userscourses/destroy'
  get 'users_courses/index'
  get 'users_courses/create'
  get 'users_courses/show'
  get 'users_courses/update'
  get 'users_courses/destroy'
  get 'userscourse/index'
  get 'userscourse/create'
  get 'userscourse/show'
  get 'userscourse/update'
  get 'userscourse/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/health', to: 'health#health'
  resources :phrases, only: [:index, :show, :create, :update, :destroy]
  resources :lessons, only: [:index, :show, :create, :update, :destroy]
  resources :courses, only: [:index, :show, :create, :update, :destroy]
  resources :userscourses, only: [:index, :show, :create, :update, :destroy]
end
