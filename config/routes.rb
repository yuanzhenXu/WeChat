Rails.application.routes.draw do
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  delete 'delete', to: 'users#destroy'
  # get 'current_user', to: 'users#show'
  get 'auth/wechat/callback', to: 'wechat/welcome#create'

  # root 'welcome#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  namespace :admin do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    get 'logout', to: 'sessions#destroy'

    resources :users
    resources :wechat_users
    resources :shared_logs
    resources :wechat_tags

    root 'sessions#new'
  end

  namespace :wechat do
    get 'home', to: 'home#index'
  end
  # resource :wechat_user
  resources :wechat_tags do
    member do
      get :users
    end
  end
  resources :users, only: [:index, :show, :update] do
    resources :shared_logs, only:[:index]
  end
  resources :users
  resources :wechat_users
  resources :wechat_tags, only: [:index, :create]
  resource :wechat, only: [:show, :create]
  resources :shared_logs, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
