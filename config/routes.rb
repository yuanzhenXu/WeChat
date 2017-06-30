Rails.application.routes.draw do
  get 'signup', to: 'users#new'
  get 'auth/wechat/callback' , to: 'welcome#index'
  root 'welcome#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resource :users
  resource :wechat, only: [:show, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
