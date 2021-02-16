Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/users')
  resources :setts
  resources :users do
    get 'wilks_history', to: 'workouts#wilks_history'
    resources :workouts
  end
end
