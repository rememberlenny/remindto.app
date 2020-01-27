class AssetsJsController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!
  
  def remind
    @account_uid = assets_params[:id]

    if @account_uid && assets_params.keys.count == 1
      @target_el = 'ReadturnEmbedTarget'
      @startOpen = false
      @shouldBeInline = false
      @wasSent = false
    else
      @target_el = assets_params[:target] ? assets_params[:target] : 'ReadturnEmbedTarget'
      @startOpen = assets_params[:startOpen] ? assets_params[:startOpen] : false
      @shouldBeInline = assets_params[:shouldBeInline] ? assets_params[:shouldBeInline] : false
      @wasSent = assets_params[:wasSent] ? assets_params[:wasSent] : false
    end

    render :file => "./assets_js/bundle_wrapper.js.erb"
  end

  def assets_params
    params.permit(:id, :target, :startOpen, :shouldBeInline, :wasSent)
  end
end