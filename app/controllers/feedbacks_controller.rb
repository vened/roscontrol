class FeedbacksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @feedback = Feedback.new(feeback_params)
    if @feedback.save
      render :json => @feedback
    else
      render :json => {errors: @feedback.errors}
    end
  end

  private

  def feeback_params
    params.require(:feedback).permit(:name, :email, :phone, :message)
  end

end
