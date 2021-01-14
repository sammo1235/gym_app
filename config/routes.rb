Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/workouts')
  resources :workouts, :setts, :users
end
