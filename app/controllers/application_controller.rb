class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # def default_url_options
  #   {:locale => I18n.locale}
  # end
  # 
  # before_filter :get_language
  # 
  # def get_language
  #   if params[:locale].nil?
  #     I18n.locale = "ru"
  #   else
  #     I18n.locale = params[:locale]
  #   end
  # end

end
