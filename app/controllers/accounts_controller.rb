class AccountsController < ApplicationController
  load_and_authorize_resource :user
  skip_before_action :verify_authenticity_token
  before_action :add_allow_credentials_headers

  def new
    @account = Account.new(owner_id: @current_user.id)
  end

  def reminders
    @account = Account.find(params[:id])
    is_users_account
  end

  def integration
    @account = Account.find(params[:id])
    is_users_account
  end

  def edit
    @account = Account.find(params[:id])
    is_users_account
  end

  def integrations
    @account = Account.find(params[:id])
    is_users_account
    @reminders = Later.where account_id: @account.id
    subscriber_ids = @reminders.uniq.pluck(:user_id)
    @subscribers = []
    subscriber_ids.each do |id|
      user = User.find id
      @subscribers << user
    end
  end


  def signups
    @account = Account.find(params[:id])
    is_users_account
    @reminders = Later.where account_id: @account.id
    subscriber_ids = @reminders.uniq.pluck(:user_id)
    @subscribers = []
    subscriber_ids.each do |id|
      user = User.find id
      @subscribers << user
    end
  end

  def stats
    @account = Account.find(params[:id])
    is_users_account
    @reminders = Later.where account_id: @account.id
    subscriber_ids = @reminders.uniq.pluck(:user_id)
    @subscribers = []
    subscriber_ids.each do |id|
      user = User.find id
      @subscribers << user
    end
  end

  def update
    @account = Account.find(params[:id])
    is_users_account
    if @account.update_attributes(account_params)
      redirect_to user_home_path, notice: "Your updates were made successfully."
    else
      redirect_to edit_account_path(params[:id]), alert: "There was an issue with your update."
    end
  end

  def change
    @current_user.account_id = params['id']
    @current_user.save
    redirect_to user_home_path
  end

  def checkout

  end

  def checkout_subscription
    begin
      customer = Stripe::Customer.create(
        :email => @current_user.email,
        :source => params[:stripeToken],
        :plan => "remindtoreadpremium",
      )
      @current_user.stripe_token_type = params[:stripeToken]
      @current_user.stripe_token = params[:stripeTokenType]
      @current_user.stripe_customer_id = customer.id
      @current_user.subscription_type = "premium"
      @current_user.save
      # mixpanel.track("Complete Payment",  "Payment ID"  => @current_user.stripe_token,
      #                                     "Amount"      => "20")
      redirect_to user_home_path, notice: "Thank you for signing up!"
    rescue => ex
      redirect_to pricing_path, alert: "There was an issue with your card."
    end
  end

  def create
    @account = Account.new(account_params)
    if !@account.color
      @account.color = '#1a93f8'
    end
    @account.owner_id = @current_user.id
    @account.save(validate: false)
    # mixpanel.track("Create Remind Form", "Title" => @account.uid)

    @current_user.account_id = @account.id
    @current_user.save

    if @account.valid?
      redirect_to user_home_path
    else
      redirect_to new_account_path
    end
  end

  private

    def is_users_account
      if @current_user.id != @account.owner_id
        redirect_to user_home_path, notice: "You do not have permissions to view this path"
      end
    end

    def account_params
      params.require(:account).permit(:domain, :remove_branding_flag, :logo_url, :owner_id, :created_at, :updated_at, :company_name, :uid, :company_image, :company_image_id, :company_image_filename, :company_image_size, :company_image_content_type, :has_script_setup, :cta, :description, :color)
    end
end