Rails.application.routes.draw do
  root "pages#home"
  resources :reviews, only: [ :index ]
  resources :nps_scores, only: [ :index ]
end
