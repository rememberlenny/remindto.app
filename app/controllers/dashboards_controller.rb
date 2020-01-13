require "oembed"

class DashboardsController < ApplicationController
  load_and_authorize_resource :user
  before_action :check_accounts

  def new_subscriber 
    
  end

  def remind_form_maker
    @remind_forms = RemindForm.where(account_id: @account.id)
  end

  def remind_form
    @remind_form = RemindForm.find(params[:uuid])
  end
  
  def subscribers
    remind_user_ids = Later.all.where(account_id: @account.id).distinct.pluck(:user_id)
    @remind_users = RemindUser.where(id: remind_user_ids)
  end

  def show
    remind_user_param = params[:remind_user_id]
    @remind_user = RemindUser.find(remind_user_param)
    @remind_user_laters = Later.all.where(account_id: @account.id, user_id: @remind_user.id)
  end

  def home
    day_length = 7
    @user_ids = Later.where(account_id: @account.id).pluck('user_id').uniq
    @session_ids = Later.where(account_id: @account.id).pluck('id').count
    @unique_urls = Later.all.where(account_id: @account.id).distinct.pluck(:url)
    @grouped_laters = {}
    @unique_urls.each do |url|
      @grouped_laters[url.to_sym] = Later.all.where(account_id: @account.id, url: url)
    end
  end

  def install
  end

  def feed

  end

  def old_feed

  end
end
