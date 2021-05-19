Rails.application.routes.draw do
  
  root to: 'home#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users, :only => [:show, :edit, :update]
  resources :rooms, :only => [:index, :new, :create, :show]

  get 'reservations/new'
  post 'reservations/confirm'
  post 'reservations/back'
  post 'reservations/complete'
  get 'reservations/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
