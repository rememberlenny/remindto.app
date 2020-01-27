class RemindEmailMailer < ActionMailer::Base
  default from: Rails.application.config.settings.mail.from
  layout 'emails/reminder'

  def reminder_email(remind_user)
    return false unless load_remind_user(remind_user).present?
    mail to: @remind_user.email, subject: 'This is a reminder email'
  end

  protected

  def load_remind_user(remind_user)
    @remind_user = remind_user.is_a?(RemindUser) ? remind_user : RemindUser.find(remind_user)
  end
end
