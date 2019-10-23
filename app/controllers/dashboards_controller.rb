require "oembed"

class DashboardsController < ApplicationController
  load_and_authorize_resource :user
  before_action :check_accounts

  def home
    if !@current_user.account_id
      redirect_to new_account_path, notice: "Create your first reminder form to get started"
    else
      @account = Account.find @current_user.account_id
      # remind_oembed = OEmbed::Provider.new(oembed_url, :json)
      # remind_oembed << request.base_url + "/f/*"
      # url = request.base_url + '/f/' + account.uid
      # @reminder = remind_oembed.get(url)
    end
  end

  def install
    if !@current_user.nil? && !@current_user.account_id
      redirect_to new_account_path
    else
      @current_account = Account.find @current_user.account_id
    end
  end

  def feed

  end

  def old_feed

  end


end
