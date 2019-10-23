class ContentMailer < ActionMailer::Base
  default from: Rails.application.config.settings.mail.from
  layout 'emails/content'

  def content_email(later_id)
    @later = Later.find(later_id)
    @later.has_sent = true
    @later.save
    @user = User.find(@later.user_id)
    email = @user.email
    track user: @user
    mail to: email, subject: 'Sending to you'
  end

  protected

  def load_later(later_id)
    @later = Later.find(later_id)
  end
end
