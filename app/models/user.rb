class User < ActiveRecord::Base
  attr_accessor :publication_size, :publication_name
  # include Concerns::UserImagesConcern

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #  :trackable, :confirmable, :timeoutable, :lockable

  # has_many :messages, class_name: "Ahoy::Message"
  has_many :accounts
  has_many :laters, dependent: :destroy

  has_many :authentications, dependent: :destroy, validate: false, inverse_of: :user do
    def grouped_with_oauth
      includes(:oauth_cache).group_by { |a| a.provider }
    end
  end

  after_create :create_account

  def create_account
    @user = User.last
    @account = Account.new
    @account.publication_size = publication_size
    @account.company_name = publication_name
    @account.owner_id = @user.id
    @account.save
    @user.account_id = @account.id
    @user.save
  end

  def display_name
    first_name.presence || email.split("@")[0]
  end

  # Case insensitive email lookup.
  #
  # See Devise.config.case_insensitive_keys.
  # Devise does not automatically downcase email lookups.
  def self.find_by_email(email)
    find_by(email: email.downcase)
    # Use ILIKE if using PostgreSQL and Devise.config.case_insensitive_keys=[]
    #where('email ILIKE ?', email).first
  end

  # Override Devise to allow for Authentication or password.
  #
  # An invalid authentication is allowed for a new record since the record
  # needs to first be saved before the authentication.user_id can be set.
  def password_required?
    if authentications.empty?
      super || encrypted_password.blank?
    elsif new_record?
      false
    else
      super || encrypted_password.blank? && authentications.find { |a| a.valid? }.nil?
    end
  end

  # Merge attributes from Authentication if User attribute is blank.
  #
  # If User has fields that do not match the Authentication field name,
  # modify this method as needed.
  # def reverse_merge_attributes_from_auth(auth)
  #   auth.oauth_data.each do |k, v|
  #     self[k] = v if self.respond_to?("#{k}=") && self[k].blank?
  #   end
  # end

  # Do not require email confirmation to login or perform actions
  def confirmation_required?
    false
  end
end
