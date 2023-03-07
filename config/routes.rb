Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }
  
  namespace :api do
    namespace :v1 do
      resources :cars
      resources :reservations
    end
  end
end
