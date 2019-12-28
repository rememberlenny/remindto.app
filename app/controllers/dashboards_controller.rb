require "oembed"

class DashboardsController < ApplicationController
  load_and_authorize_resource :user
  before_action :check_accounts

  def home
  end

  def install
  end

  def feed

  end

  def old_feed

  end


end
