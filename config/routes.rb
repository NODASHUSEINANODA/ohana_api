Rails.application.routes.draw do
  # NOTE : 開発環境で`/letter_opener`で送信したメールを確認できる(実際に送信して検証したい際はコメントアウトしてください)
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

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

