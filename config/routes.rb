Rails.application.routes.draw do
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
