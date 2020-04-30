# Preview all emails at http://localhost:3000/rails/mailers/auto_mailer
class AutoMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/auto_mailer/notification_email
  def notification_email
    AutoMailer.notification_email
  end

end
