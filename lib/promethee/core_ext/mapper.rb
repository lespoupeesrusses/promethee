ActionDispatch::Routing::Mapper.class_eval do
  def promethee path: :promethee
    namespace :promethee, path: path.to_s, module: nil  do
      post 'preview' => 'promethee#preview', as: :preview
      post 'blob' => 'promethee#blob_create'
      get 'blob/:id' => 'promethee#blob_show'
    end
  end
end
