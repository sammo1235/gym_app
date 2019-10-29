Rails.application.routes.draw do
  root 'pages#home'
  get '/status', controller: 'application', action: 'status'
  resources :work_outs
  resources :lifts
  resources :work_units
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
