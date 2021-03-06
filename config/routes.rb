Rails.application.routes.draw do
  devise_for :users
  root to: redirect('/users')
  resources :setts
  resources :users do
    get 'workouts/filter', to: 'workouts#filter'
    get 'setts/filter', to: 'setts#filter'
    resources :workouts do
      resources :comments
    end
  end
end
