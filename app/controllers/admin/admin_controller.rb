class Admin::AdminController < ApplicationController
  include Admin::SessionsHelper
  layout "admin/layouts/application"
end
