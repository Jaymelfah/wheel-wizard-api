Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions'
  }
  
  namespace :api do
    namespace :v1 do
      resources :cars
      resources :reservations
    end
  end
end
