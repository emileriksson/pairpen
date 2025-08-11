class ApplicationsController < ApplicationController
  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    
    if @application.save
      # Send verification email
      PenPalMailer.verification_email(@application).deliver_now
      redirect_to root_path, notice: 'Thank you for applying! Please check your email to verify your application.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @application = Application.find_by(status_token: params[:token])
    
    if @application.nil?
      redirect_to root_path, alert: 'Invalid status link.'
    end
  end
  
  def verify
    @application = Application.find_by(verification_token: params[:token])
    
    if @application.nil?
      redirect_to root_path, alert: 'Invalid verification link.'
    elsif @application.verified?
      redirect_to application_status_path(@application.status_token), notice: 'Email already verified!'
    else
      @application.update!(
        verified_at: Time.current,
        status: 'pending'
      )
      redirect_to application_status_path(@application.status_token), 
                  notice: 'Email verified successfully! Your application is now being reviewed.'
    end
  end
  
  private
  
  def application_params
    params.require(:application).permit(:email, :application_text)
  end
end
