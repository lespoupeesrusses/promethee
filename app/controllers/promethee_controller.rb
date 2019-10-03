class PrometheeController < ApplicationController
  # This is acceptable because the iframe is sandboxed
  skip_before_action :verify_authenticity_token, only: :preview

  def preview
    @data = params[:data]
    render 'preview', layout: params[:preview_layout] if params.include? :preview_layout
  end

  def blob_create
    io = params[:file].to_io
    filename = params[:file].original_filename
    content_type = params[:file].content_type
    blob = ActiveStorage::Blob.create_after_upload! io: io, filename: filename, content_type: content_type
    render json: { id: blob.signed_id, name: filename }
  end

  def blob_show
    # as this is called only from promethee preview it sends an image resized to 720
    blob_id = params[:id]
    if blob_id.to_i.to_s == blob_id
      blob = ActiveStorage::Blob.find(blob_id)
    else
      begin
        blob = ActiveStorage::Blob.find_signed(blob_id)
      rescue
        raise ActiveRecord::RecordNotFound
      end
    end

    if blob.image? && blob.variable?
      redirect_to url_for(blob.variant(resize: '720>'))
    elsif blob.video?
      redirect_to url_for(blob.preview(resize: '720>'))
    else
      redirect_to url_for(blob)
    end
  end
end
