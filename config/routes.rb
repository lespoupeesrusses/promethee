Rails.application.routes.draw do
  namespace :promethee, path: Promethee.configuration.route_scope, module: nil  do
    post 'preview' => 'promethee#preview', as: :preview
  end
end
