class PrometheeController < ApplicationController
  # This is acceptable because the iframe is sandboxed
  skip_before_action :verify_authenticity_token

  def preview
    @data = params[:data]
  end
end
