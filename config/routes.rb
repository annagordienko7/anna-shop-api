Rails.application.routes.draw do
  # Явно указываем использовать наши контроллеры из папки users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  resources :items, only: [:index, :create, :update]
  resources :orders, only: [:index, :create]
  resources :users, only: [:index, :update]
end
