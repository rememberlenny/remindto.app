class Account < ActiveRecord::Base
  has_many :users

  after_create :generate_uid
  after_create :send_welcome_emails
  after_create :make_default_forms

  def self.find_param(param)
    find_by! public_uid: param.split('-').first
  end
  
  def to_param
    "#{public_uid}-#{tile.gsub(/\s/,'-')}"
  end

  def make_default_forms
    RemindForms.create(title: 'Need to stop reading?', cta: 'Send email', form_blocks: '', account_id: self.id)
  end

  def send_welcome_emails
    # UserMailer.delay.welcome_email(self.id)
    # UserMailer.delay_for(5.days).find_more_friends_email(self.id)
  end

  def self.check_is_unique_uid uid
    uu = Account.find_by_uid(uid)
    if uu.nil?
      return true
    end
    return false
  end

  def generate_uid
    uid = SecureRandom.hex(4) + '-' + SecureRandom.hex(1)
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
