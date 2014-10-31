class MenuCell < Cell::Rails

  def list
    # @pages = Page.all.order('lft ASC')
    @pages = Page.roots.where(menu: true)
    @current_path = request.fullpath.gsub!(/\//, '')
    render
  end

end
