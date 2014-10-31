class NewsCell < Cell::Rails

  def list
    @news = News.all.order(created_at: :desc).limit(4)
    render
  end

end
