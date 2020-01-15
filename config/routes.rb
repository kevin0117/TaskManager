Rails.application.routes.draw do
  resources :tasks
  #PAGE
  root 'pages#index'
  # root 'tasks#index'
end
