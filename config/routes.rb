Rails.application.routes.draw do
  get 'user/index'
  resource :wechat, only: [:show, :create]
  get 'auth/wechat/callback' , to: 'welcome#index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
