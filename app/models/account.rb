class Account < ActiveRecord::Base
  has_many :users

  after_create :generate_uid
  after_create :send_welcome_emails

  # validates :color, :css_hx_color => true

  attachment :company_image

  def send_welcome_emails
    # UserMailer.delay.welcome_email(self.id)
    # UserMailer.delay_for(5.days).find_more_friends_email(self.id)
  end

  def self.check_is_unique_uid uid
    uu = Account.where(uid: uid)
    if uu.count == 0
      return true
    end
    return false
  end

  def generate_uid
    uid = SecureRandom.hex(4) + '-' + SecureRandom.hex(6) + '-' + SecureRandom.hex(4)
    checked = Account.check_is_unique_uid(uid)
    if checked == true
      self.uid = uid
      self.save
    else
      generate_uid
    end
  end

  def self.check_has_script_setup id
    uu = Account.where(uid: id)
    if uu.count > 0
      u = uu.first
      u.has_script_setup = true
      u.save
    end
  end


  def self.check_account_status id
    Account.where(domain: id)
  end

end
