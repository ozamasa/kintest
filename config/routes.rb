Rails.application.routes.draw do
  get '/pictures', to: 'pictures#index'
  post '/pictures', to: 'pictures#create'

  root 'pictures#index'
end
