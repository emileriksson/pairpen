class PenPalMailer < ApplicationMailer
  default from: 'noreply@pairpen.com'

  def verification_email(application)
    @application = application
    @verification_url = verify_email_url(application.verification_token)
    @status_url = application_status_url(application.status_token)
    
    mail(
      to: application.email,
      subject: 'Please verify your pen pal application'
    )
  end

  def approval_email(application)
    @application = application
    @status_url = application_status_url(application.status_token)
    
    mail(
      to: application.email,
      subject: 'Your pen pal application has been approved!'
    )
  end

  def rejection_email(application)
    @application = application
    
    mail(
      to: application.email,
      subject: 'Your pen pal application status'
    )
  end

  def match_notification_email(application, match_application)
    @application = application
    @match_application = match_application
    @status_url = application_status_url(application.status_token)
    
    mail(
      to: application.email,
      subject: "You've been matched with a pen pal!"
    )
  end
end
