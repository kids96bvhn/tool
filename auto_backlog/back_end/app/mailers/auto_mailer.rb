class AutoMailer < ApplicationMailer
  default from: Constants::NAME_FROM

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.auto_mailer.notification_email.subject
  #
  def notification_email(tickets)
    @tickets = tickets
    @time = Time.now.strftime("%d/%m/%Y %H:%M")
    mail to: Constants::MAIL_TO, subject: Constants::SUBJECT
  end
end
