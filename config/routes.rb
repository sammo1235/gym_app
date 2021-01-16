Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/users')
  resources :setts
  resources :users do
    resources :workouts
  end
end
