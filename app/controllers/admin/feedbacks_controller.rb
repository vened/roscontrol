class Admin::FeedbacksController < Admin::AdminController
  before_action :signed_in_manager
  skip_before_action :verify_authenticity_token

  def index
    @feedbacks = Feedback.all
  end


  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to admin_feedbacks_url, notice: 'Отзыв успешно удален!' }
      format.json { head :no_content }
    end
  end


  private
  def feeback_params
    params.require(:feedback).permit(:name, :email, :phone, :message)
  end

end
