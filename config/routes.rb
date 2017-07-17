Rails.application.routes.draw do
  resource :wechat, only: [:show, :create]
  resources :visitors
  get 'auth/wechat/callback', to: 'wechat/welcome#create'

  namespace :admin do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :users
    resources :wechat_users
    resources :view_logs
    resources :shared_logs, only: [:index, :create]
    resources :wechat_tags
    resources :users, only: [:index, :show, :update] do
      resources :shared_logs, only:[:index]
      resources :wiew_logs, only: [:index]
    end

    resources :wechat_tags do
      member do
        get :users
      end
    end

    root 'sessions#new'
  end

  namespace :wechat do
    get 'home', to: 'home#index'
    get 'user' => 'user#index'

    resources :shared_logs, only: [:create] do
      resource :user
    end
  end

  root  'visitors#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
