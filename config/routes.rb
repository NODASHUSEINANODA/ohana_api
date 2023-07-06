# frozen_string_literal: true

Rails.application.routes.draw do
  # NOTE : 開発環境で`/letter_opener`で送信したメールを確認できる(実際に送信して検証したい際はコメントアウトしてください)
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :companies, controllers: { registrations: 'companies/registrations' }

  resources :employees

  root to: 'employees#index'

  get '/next_order', to: 'order_details#edit'
  put '/next_order', to: 'order_details#update'

  devise_scope :company do
    get '/companies/sign_out' => 'devise/sessions#destroy'
  end

  devise_scope :company do
    get '/companies/sign_up/confirm' => 'devise/registrations#confirm'
  end
end
