Rails.application.routes.draw do
  root 'pages#home'
  get '/status', controller: 'application', action: 'status'
  resources :work_outs
  get 'work_outs/:id/work_units', to: 'work_outs#show_work_units'
  resources :lifts
  resources :work_units
  get 'work_units/:id/lift', to: 'work_units#get_lift'
  resources :users
  get 'users/:id/work_outs', to: 'users#show_workouts_for_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
