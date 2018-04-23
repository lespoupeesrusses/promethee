class PrometheeController < ApplicationController
  # This is acceptable because the iframe is sandboxed
  skip_before_action :verify_authenticity_token, only: :preview

  def preview
    @data = params[:data]
  end

  def blob_create
    io = params[:file].to_io
    filename = params[:file].original_filename
    content_type = params[:file].content_type
    blob = ActiveStorage::Blob.create_after_upload! io: io, filename: filename, content_type: content_type
    render json: { id: blob.id, name: filename }
  end

  def blob_show
    blob = ActiveStorage::Blob.find params[:id]
    redirect_to url_for(blob.variant(resize: '720'))
  end
end
