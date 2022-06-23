module ItemSearch
extend ActiveSupport::Concern

  def set_parents
    @set_parents = Category.where(ancestry: nil)
  end

end