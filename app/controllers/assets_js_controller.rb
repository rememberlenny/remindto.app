class AssetsJsController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!
  
  def remind
    @target_el = params[:target]
    @startOpen = params[:startOpen]
    @shouldBeInline = params[:shouldBeInline]
    @wasSent = params[:wasSent]
    respond_to do |format|
      format.js {
        render :file => "assets_js/bundle_wrapper.js.erb"
      }
    end
  end
end