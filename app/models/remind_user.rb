class RemindUser < ApplicationRecord

  def self.scheduled_delay_time(delay_param)
    parse_delay_param(delay_param)
  end

  def self.create_email_if_needed(email)
    rr = RemindUser.find_by_email(email)
    
    if rr.nil?
      rr = RemindUser.new(email: email)
      rr.save
    end

    rr.id
  end

  def self.parse_delay_param(delay_param)
    results = {
      'time-now': Time.now + 5.minutes,
      'time-hour-4': Time.now + 4.hours,
      'time-day-24': Time.now + 24.hours
      # 'time-weekend': Time.now + Chronic.parse('next 6') + 12.hours,
    }
    
    results[delay_param.to_sym]
  end
end
