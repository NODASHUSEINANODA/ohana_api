Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # ログイン機能のルーティング
  mount_devise_token_auth_for 'Company', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
  # ログインユーザー取得のルーティング
  namespace :auth do
    resources :sessions, only: %i[index]
  end

  namespace 'api' do
    resources :employees
    get '/healthcheck', to: 'healthcheck#index'
  end
end
