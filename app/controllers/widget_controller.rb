class WidgetController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token
  before_filter :add_allow_credentials_headers

  def embed
    response.headers["X-FRAME-OPTIONS"] = "ALLOWALL"
    @id = params[:id]
    uu = Account.where(uid: @id)
    if uu.count > 0
      @account = uu.first
      render file: 'widget/embed.js.erb', content_type: 'text/javascript'
    else
      render json: { response: 'error', message: 'You must register your domain at https://remindtoapp.com/a/signup. To get your account_key, associate a domain name to your account.' }
    end
  end

  def embed_page
    @id = params[:id]
    uu = Account.where(uid: @id)
    if uu.count > 0
      @account = uu.first
      render file: 'widget/embed_page.js.erb', content_type: 'text/javascript'
    else
      render json: { response: 'error', message: 'You must register your domain at https://remindtoapp.com/a/signup. To get your account_key, associate a domain name to your account.' }
    end
  end

  def button
    if !params[:id].nil?
      id = params[:id]
      Account.delay.check_account_status(id)
    end
    render :layout => false
  end

  def init_script
    id = params[:id]
    Account.delay.check_has_script_setup id
    obj = { response: 'success' }
    render json: obj
    # confirm ping from webpage
    # confirm has_script_installed is working
  end
end
