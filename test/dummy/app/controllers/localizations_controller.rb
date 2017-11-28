class LocalizationsController < ApplicationController
  before_action :load

  # GET /localizations
  def index
    @localizations = Localization.all
  end

  # GET /localizations/1
  def show
  end

  # GET /localizations/new
  def new
    @localization = Localization.new
    @localization.page = @page
  end

  # GET /localizations/1/edit
  def edit
  end

  # POST /localizations
  def create
    @localization = Localization.new(localization_params)

    if @localization.save
      redirect_to @localization, notice: 'Localization was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /localizations/1
  def update
    if @localization.update(localization_params)
      redirect_to @localization, notice: 'Localization was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /localizations/1
  def destroy
    @localization.destroy
    redirect_to localizations_url, notice: 'Localization was successfully destroyed.'
  end

  private

  def load
    @localization = Localization.find(params[:id]) if params.include? :id
    @page = Page.find params[:page_id]
  end

  # Only allow a trusted parameter "white list" through.
  def localization_params
    params.require(:localization).permit(:page_id, :data)
  end
end
