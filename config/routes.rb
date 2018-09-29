Rails.application.routes.draw do
  
  get 'contacts' => 'contacts#index', as: 'contacts_index'
  match 'contacts/confirm' ,:via => :post
  match 'contacts/create' ,:via => :post

  namespace :staff do
    devise_for :users, controllers: {
    sessions: 'staff/users/sessions',
    registrations: 'staff/users/registrations',
    confirmations: 'staff/users/confirmations',
    passwords: 'staff/users/passwords'
    }
  end

  resources :topics
  resources :dashboards
  
  resources :tags
  resources :categories
  resources :posts do
    put 'published' => 'posts#published', on: :member, as: :published
    put 'unpublished' => 'posts#unpublished', on: :member, as: :unpublished
  end

  get 'blog' => 'blog#index'
  get 'blog/:id' => 'blog#show', as: 'blog_show'
  get 'blog/archives/:id' => 'blog#archives', as: 'blog_archives'

  root 'pages#index'
  get 'about' => 'pages#about', as: 'pages_about'


  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
