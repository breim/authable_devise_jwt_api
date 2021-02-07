Rails.application.routes.draw do
  devise_for :employees

  get '/me', to: 'pages#index'
end
