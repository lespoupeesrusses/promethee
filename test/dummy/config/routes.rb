Rails.application.routes.draw do
  resources :pages
  root to: 'application#index'
end
