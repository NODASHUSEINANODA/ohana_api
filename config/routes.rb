Rails.application.routes.draw do
  devise_for :companies, controllers: { registrations: 'companies/registrations' }

  namespace 'api' do
    get '/healthcheck', to: 'healthcheck#index'
  end

  resources :employees

  root to: 'employees#index'

  devise_scope :company do
    get '/companies/sign_out' => 'devise/sessions#destroy'
  end

  devise_scope :company do
    get '/companies/sign_up/confirm' => 'devise/registrations#confirm'
  end

end

