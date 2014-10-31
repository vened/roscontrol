class Admin::DashboardController < Admin::AdminController

  before_action :signed_in_manager, only: [:index]
  
  def index
    
  end
  
end
