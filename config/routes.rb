Rails.application.routes.draw do
  root to: redirect('/workouts')
  resources :workouts, :setts
end
