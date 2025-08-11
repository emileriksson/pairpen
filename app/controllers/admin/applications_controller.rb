class Admin::ApplicationsController < Admin::ApplicationController
  before_action :set_application, only: [:show, :approve, :reject]
  
  def index
    @applications = Application.includes(:matches_as_first, :matches_as_second)
                              .order(created_at: :desc)
    
    # Filter by status if provided
    if params[:status].present? && Application::STATUSES.include?(params[:status])
      @applications = @applications.by_status(params[:status])
    end
    
    @applications = @applications.page(params[:page])
    @status_counts = Application.group(:status).count
  end

  def show
  end

  def approve
    if @application.status == 'pending'
      @application.update!(status: 'approved')
      PenPalMailer.approval_email(@application).deliver_now
      redirect_to admin_applications_path, notice: "Application approved and email sent!"
    else
      redirect_to admin_applications_path, alert: "Can only approve pending applications."
    end
  end

  def reject
    if @application.status == 'pending'
      @application.update!(status: 'rejected')
      PenPalMailer.rejection_email(@application).deliver_now
      redirect_to admin_applications_path, notice: "Application rejected and email sent."
    else
      redirect_to admin_applications_path, alert: "Can only reject pending applications."
    end
  end

  def bulk_update
    application_ids = params[:application_ids] || []
    action = params[:bulk_action]
    
    if application_ids.empty?
      redirect_to admin_applications_path, alert: "Please select at least one application."
      return
    end
    
    applications = Application.where(id: application_ids, status: 'pending')
    
    case action
    when 'approve'
      applications.each do |app|
        app.update!(status: 'approved')
        PenPalMailer.approval_email(app).deliver_now
      end
      redirect_to admin_applications_path, notice: "#{applications.count} applications approved!"
      
    when 'reject'
      applications.each do |app|
        app.update!(status: 'rejected')
        PenPalMailer.rejection_email(app).deliver_now
      end
      redirect_to admin_applications_path, notice: "#{applications.count} applications rejected."
      
    else
      redirect_to admin_applications_path, alert: "Invalid bulk action."
    end
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end
end