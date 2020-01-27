class ReminderFormPageController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!
  # skip_after_action :intercom_rails_auto_include
  before_action :add_allow_credentials_headers

  def show
    response.headers["X-FRAME-OPTIONS"] = "ALLOWALL"
    @id = params[:id]
    @account = Account.find_by_uid(@id)
    if @account.nil?
      redirect_to root_path, alert: "The account you are looking for does not exist. Please check the reminder URL."
    end
    @user = User.find @account.owner_id
    if params[:target]
      url = params[:target]
      @referrer = url
    elsif params[:referrer]
      url = params[:referrer]
      urlrr = URI.parse url
      querys = urlrr.query
      if querys && querys.length > 1
        splitQuery = querys.split("postId=")
        if splitQuery.length > 1
          @referrer = "https://medium.com/post/" + splitQuery[1]
        else
          @referrer = url
        end
      else
        @referrer = url
      end
    else
      @referrer = "https://readturn.com/?notice=NoReferrWasSet"
    end
  end
end
