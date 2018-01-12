class DemoController < ApplicationController
  before_action :load

  protected

  def load
    @data = Demo.data
    @localization = Demo.localization
  end
end
