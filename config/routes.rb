Rails.application.routes.draw do
  get '/status', controller: 'application', action: 'status'
  get 'work_outs/:uuid', to: 'work_outs#show'
  get 'work_outs/:uuid.json', to: 'work_outs#show'
  get 'work_outs/:uuid/work_units', to: 'work_outs#show_work_units'
  resources :work_outs
  resources :lifts
  resources :work_units
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
