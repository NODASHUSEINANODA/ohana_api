Rails.application.routes.draw do
  get 'home/index'
  devise_for :companies, controllers: { registrations: 'companies/registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  namespace 'api' do
    get '/healthcheck', to: 'healthcheck#index'
  end

  resources :employees

  root to: 'home#index'

  devise_scope :company do
    get '/companies/sign_out' => 'devise/sessions#destroy'
  end  

  devise_scope :company do
    get '/companies/sign_up/confirm' => 'devise/registrations#confirm'
  end 

end

