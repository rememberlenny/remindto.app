require 'uri'

class LatersController < ApplicationController
  load_and_authorize_resource :user
  before_action :check_accounts
  # skip_authorization_check :only => [:new, :test]
  # skip_before_action :authenticate_user!, :only => [:new, :test]
  # before_action :add_allow_credentials_headers, :only =>  [:new, :test]

  def test
    render json: {response: 'Success', email: params, message: 'Good job'}
  end

  def index
    @laters = Later.where(account_id: @current_user.account_id).where('destined_at >= ?', Time.now).order(destined_at: :asc)
  end

  def old_index
    if @current_user.account_id.nil?
      flash[:notice] = 'Please follow the instructions below to install'
      redirect_to install_path
    end

    @laters = Later.where(account_id: @current_user.account_id).where('destined_at < ?', Time.now).order(destined_at: :asc)
  end

  def settings

  end

  def show
    @later = Later.find params[:id]
  end

  def create

  end

  def update
    later_id = params[:laterid];
    ll = Later.where(id: later_id)
    if ll.count > 0
      email = params[:email]
      url = params[:url]
      renew = params[:renew]
      delay_param = params[:delay]
      if !delay_param.nil?
        destined = Chronic.parse('in ' + URI::decode(delay_param) )
      else
        destined = nil
      end
      output = "No good"
      if !email.nil? && !url.nil?

        uu = User.where(email: email)
        if uu.count == 0
          u = User.create(email: email, password: Faker::DizzleIpsum.words(4).join('!').first(20))
        else
          u = uu.first
        end

        ll = Later.where(url: url, user_id: u.id)
        if ll.count == 0
          l = Later.create(url: url, account_id: account_id, user_id: u.id, created_at: Time.now.utc)
        else
          ll.where('destined_at >= ?', Date.today).order(:destined_at)
          l = ll.first
          l.modified_at = Time.now.utc
        end

        if !destined.nil?
          if destined.future?
            l.destined_at = destined
          end
        else
          l.destined_at = Time.now.utc + 4.hours
        end
        if !renew.nil?
          l.has_sent = false
        end

        l.save
        output = {response: 'success', data: l}

        Later.delay.get_ograph_content(l.id)
      end

      redirect_to success_later_update_path
    else
      render json: {response: 'Error', message: 'The account ID is not recognized.', id: account_uid}
    end
  end

  def check_og_graph
    puts params
    url_string = params[:url]
    if url_string =~ URI::regexp
      open_graph = MetaInspector.new(url_string)
      render :json => {
        response: 'success',
        code: 200,
        open_graph: open_graph,
        param: url_string
      }
    else
      render :json => {
        response: 'failed',
        code: 400,
        param: url_string
      }
    end
  end

  # later/new { uid: 123, email: 123, url: 123, renew: 123, delay: 123 }
  def new
    @later = Later.new
  end

  def create 
    later_params = params[:laters]
    uid = later_params[:uid]
    aa = Account.find_by_uid(uid)
    
    if !aa.nil?
      account_id = aa.id
      email = later_params[:email]
      url = later_params[:url]
      delay_param = later_params[:delay]
      
      remind_user_id = RemindUser.create_email_if_needed(email)

      RemindSetupWorker.perform_async(account_id, remind_user_id, url, delay_param)
      render json: {response: 'Success', code: 200, message: 'Data was received.'}
    else
      render json: {response: 'Success', code: 206, message: "Account ID #{uid} not found."}
    end
    

    # Trigger a REMIND
    # - Create user if needed
    # - Schedule the remind

  end

end
