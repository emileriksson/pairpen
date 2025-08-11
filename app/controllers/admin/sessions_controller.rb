class Admin::SessionsController < ApplicationController
  def new
    redirect_to admin_root_path if current_admin
  end

  def create
    admin = Admin.find_by(email: params[:email])
    
    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_root_path, notice: 'Welcome back!'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to root_path, notice: 'Logged out successfully'
  end
  
  private
  
  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  rescue ActiveRecord::RecordNotFound
    session[:admin_id] = nil
    nil
  end
end