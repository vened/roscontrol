class Admin::ManagerController < Admin::AdminController
  # before_action :signed_in_manager, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :set_manager, only: [:show, :edit, :update, :destroy]

  def index
    @managers = Manager.all
  end

  def show
  end

  def new
    @manager = Manager.new
  end

  def create
    @manager = Manager.new(manager_params)
    if @manager.save
      flash[:success] = "Новый администратор добавлен"
      redirect_to admin_manager_index_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @manager.update(manager_params)
      flash[:success] = "Данные администратора обновлены"
      redirect_to admin_manager_path
    else
      render 'edit'
    end
  end

  def destroy
    @manager.destroy
    flash[:success] = "Администратор удален"
    redirect_to admin_manager_index_path
  end

  private

  def set_manager
    @manager = Manager.find(params[:id])
  end
  
  def manager_params
    params.require(:manager).permit(:name, :email, :password, :password_confirmation)
  end

end
