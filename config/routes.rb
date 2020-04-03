Rails.application.routes.draw do
  # Sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  # Error pages
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#server_error', via: :all

  # TAG
  get 'tags/:tag', to: 'tasks#index', as: :tag

  # ADMIN
  namespace :admin, path: 'splatoon' do
    resources :tasks
    resources :users do
      member do
        get :task
      end
    end
    get 'sign_up', to: 'users#new'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end
  # TASK
  resources :tasks do
    collection do
      get :user
    end
  end
  # SESSION
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  # USER
  get 'sign_up', to: 'users#new'
  resources :users, except: [:new]
  # PAGE
  root 'pages#index'
end
