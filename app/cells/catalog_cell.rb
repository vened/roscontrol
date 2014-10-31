class CatalogCell < Cell::Rails

  def list
    # @pages = Page.all.order('lft ASC')
    @categories = Category.all
    @current_path = request.path
    render
  end

end
