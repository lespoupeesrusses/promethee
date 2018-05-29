module PrometheeData
  extend ActiveSupport::Concern

  def data=(value)
    value = JSON.parse value if value.is_a? String
    super(value)
  end
end
