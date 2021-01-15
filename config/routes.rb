Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/users')
  resources :workouts, :setts, :users
end
