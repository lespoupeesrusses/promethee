ActionDispatch::Routing::Mapper.class_eval do
  def promethee(path: :promethee)
    post "#{path}/preview" => 'promethee#preview', as: :promethee_preview
    post "#{path}/blob" => 'promethee#blob_create', as: :promethee_active_storage_create
    get "#{path}/blob/:id" => 'promethee#blob_show', as: :promethee
  end
end
