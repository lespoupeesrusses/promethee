Rails.application.routes.draw do
  namespace :promethee, path: Promethee.configuration.route_scope, module: nil  do
    post 'preview' => 'promethee#preview', as: :preview
    post 'blob' => 'promethee#blob_create'
    get 'blob/:id' => 'promethee#blob_show'
  end
end
