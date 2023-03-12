Rails.application.routes.draw do
  namespace 'api' do
    get '/healthcheck', to: 'healthcheck#index'
  end
end
