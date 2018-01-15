class LocalizationsController < ApplicationController
  before_action :load

  def index
    @localizations = Localization.all
  end

  def show
  end

  def new
    @localization = Localization.new
    @localization.page = @page
  end

  def edit
  end

  def create
    @localization = Localization.new(localization_params)
    if @localization.save
      redirect_to page_localization_path(page_id: @page.id, id: @localization.id), notice: 'Localization was successfully created.'
    else
      render :new
    end
  end

  def update
    if @localization.update(localization_params)
      redirect_to page_localization_path(page_id: @page.id, id: @localization.id), notice: 'Localization was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @localization.destroy
    redirect_to page_localizations_path(page_id: @page.id), notice: 'Localization was successfully destroyed.'
  end

  private

  def load
    @localization = Localization.find(params[:id]) if params.include? :id
    @page = Page.find params[:page_id]
  end

  def localization_params
    params.require(:localization).permit(:page_id, :data)
  end
end
