class RemindUser < ApplicationRecord

  def self.create_email_if_needed(email)
    rr = RemindUser.find_by_email(email)
    
    if rr.nil?
      rr = RemindUser.new(email: email)
      rr.save
    end

    rr.id
  end
end
