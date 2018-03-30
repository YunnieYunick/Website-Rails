Rails.application.routes.draw do

  resources :stores
  resources :works

  namespace :account do
    devise_for :members, controllers: {
    sessions: 'account/members/sessions',
    registrations: 'account/members/registrations',
    confirmations: 'account/members/confirmations',
    passwords: 'account/members/passwords'
    }
  end

  namespace :staff do
    devise_for :users, controllers: {
    sessions: 'staff/users/sessions',
    registrations: 'staff/users/registrations',
    confirmations: 'staff/users/confirmations',
    passwords: 'staff/users/passwords'
    }
  end
  
  root 'pages#index'
  get 'about' => 'pages#about', as: 'pages_about'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
