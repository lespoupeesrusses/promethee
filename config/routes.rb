Rails.application.routes.draw do
  post 'promethee/preview' => 'promethee#preview', as: 'promethee_preview'
end
