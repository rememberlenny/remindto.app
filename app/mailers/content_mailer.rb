class ContentMailer < ActionMailer::Base
  default from: Rails.application.config.settings.mail.from
  layout "emails/content"

  def content_email(later_id)
    @later = Later.find(later_id)
    @later.has_sent = true
    @later.save
    @user = RemindUser.find(@later.user_id)
    email = @user.email

    # Create an instance of Postmark::ApiClient:
    client = Postmark::ApiClient.new(Rails.application.credentials.postmark_api_token)

    # Example request
    client.deliver_with_template(
      {
        :from => Rails.application.config.settings.mail.from,
        :to => email,
        :template_alias => "welcome",
        :template_model => {
          "content_name" => @later.title,
          "content_excerpt" => @later.description,
          "content_url" => @later.url,
          "content_source" => @later.site_name,
          "reminder_set_date" => @later.created_at,
          "snooze_one_hour_url" => "snooze_one_hour_url_Value",
          "snooze_eight_hour_url" => "snooze_eight_hour_url_Value",
          "snooze_one_day_url" => "snooze_one_day_url_Value",
          "snooze_three_days_url" => "snooze_three_days_url_Value",
          "snooze_one_week_url" => "snooze_one_week_url_Value",
        },
      }
    )
  end

  protected

  def load_later(later_id)
    @later = Later.find(later_id)
  end
end
