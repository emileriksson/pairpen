class Admin::ApplicationController < ApplicationController
  before_action :authenticate_admin!
  
  protected
  
  def authenticate_admin!
    unless current_admin
      redirect_to admin_login_path, alert: 'Please log in to access the admin area.'
    end
  end
  
  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  rescue ActiveRecord::RecordNotFound
    session[:admin_id] = nil
    nil
  end
  
  helper_method :current_admin
end