# Preview all emails at http://localhost:3000/rails/mailers/pen_pal_mailer_mailer
class PenPalMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/pen_pal_mailer_mailer/verification_email
  def verification_email
    PenPalMailer.verification_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/pen_pal_mailer_mailer/approval_email
  def approval_email
    PenPalMailer.approval_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/pen_pal_mailer_mailer/rejection_email
  def rejection_email
    PenPalMailer.rejection_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/pen_pal_mailer_mailer/match_notification_email
  def match_notification_email
    PenPalMailer.match_notification_email
  end

end
