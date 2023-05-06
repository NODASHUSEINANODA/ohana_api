Rails.application.routes.draw do
  devise_for :companies
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace 'api' do
    get '/healthcheck', to: 'healthcheck#index'
  end

  resources :employees
end
