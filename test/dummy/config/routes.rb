Rails.application.routes.draw do
  resources :pages do
    resources :localizations
  end
  root to: 'application#index'
end
