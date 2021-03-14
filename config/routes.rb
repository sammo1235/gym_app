Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/users')
  resources :setts
  resources :users do
    get 'workouts/filter', to: 'workouts#filter'
    resources :workouts do
    end
  end
end
