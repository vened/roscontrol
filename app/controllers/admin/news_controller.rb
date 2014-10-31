class Admin::NewsController < Admin::AdminController
  before_action :signed_in_manager
  before_action :set_news, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @news = Admin::News.all.order(created_at: :desc)
  end

  def new
    @news = Admin::News.new
  end

  def create
    @news = Admin::News.new(news_params)
    if @news.save
      respond_to do |format|
        format.html { redirect_to admin_news_index_url, notice: 'Новость успешно добавлена' }
        format.json { head :no_content }
      end
    end
  end

  def edit
  end

  def update
    if @news.update(news_params)
      respond_to do |format|
        format.html { redirect_to admin_news_index_url, notice: 'Новость успешно обновлена' }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to admin_news_index_url, notice: 'Новость успешно удалена' }
      format.json { head :no_content }
    end
  end

  private
  def set_news
    @news = Admin::News.find(params[:id])
  end

  def news_params
    params.require(:news).permit(:path, :name, :body, :created_at)
  end
end
