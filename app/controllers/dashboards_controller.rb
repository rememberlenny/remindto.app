require "oembed"

class DashboardsController < ApplicationController
  load_and_authorize_resource :user
  before_action :check_accounts

  def subscribers
    remind_user_ids = Later.all.where(account_id: 9).distinct.pluck(:user_id)
    @remind_users = RemindUser.where(id: remind_user_ids)
  end

  def show
    remind_user_param = params[:remind_user_id]
    @remind_user = RemindUser.find(remind_user_param)
    @remind_user_laters = Later.all.where(account_id: 9, user_id: @remind_user.id)
  end

  def home
    day_length = 7
    @user_ids = Later.where(account_id: 9).pluck('user_id').uniq
    @session_ids = Later.where(account_id: 9).pluck('id').count
    @unique_urls = Later.all.where(account_id: 9).distinct.pluck(:url)
    @grouped_laters = {}
    @unique_urls.each do |url|
      @grouped_laters[url.to_sym] = Later.all.where(account_id: 9, url: url)
    end
  end

  def install
  end

  def feed

  end

  def old_feed

  end
end
