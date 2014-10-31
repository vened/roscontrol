class Admin::SessionsController < Admin::AdminController

  def new
    render layout: "admin/layouts/signin"
  end

  def create
    manager = Manager.find_by(email: params[:session][:email].downcase)
    if manager && manager.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in manager
      redirect_to '/admin'
    else
      flash.now[:danger] = 'Неверный пароль или email'
      render 'new', layout: "admin/layouts/signin"
    end
  end

  def destroy
    sign_out
    redirect_to '/admin'
  end
end