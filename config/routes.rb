Rails.application.routes.draw do
  root "pages#home"
  get "pages/home"
  get "reviews/index"
  resources :reviews
  get "up" => "rails/health#show", as: :rails_health_check
end
