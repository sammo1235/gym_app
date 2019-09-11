Rails.application.routes.draw do
  resources :work_outs
  resources :lifts
  resources :work_units
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
