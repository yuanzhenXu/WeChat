Rails.application.routes.draw do
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  delete 'delete', to: 'users#destroy'
  # get 'current_user', to: 'users#current'
  get 'auth/wechat/callback', to: 'welcome#create'

  root 'welcome#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'


  # resource :wechat_user
  resources :users
  resources :wechat_users
  resource :wechat, only: [:show, :create]
  resource :wechat_tag
  resources :shared_logs, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
