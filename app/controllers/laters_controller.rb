class LatersController < ApplicationController
  load_and_authorize_resource :user, :except => :new
  skip_authorization_check :only => :new
  skip_before_action :authenticate_user!, :only => :new
  before_action :add_allow_credentials_headers, :only => :new

  def index
    if @current_user.account_id.nil?
      flash[:notice] = 'Please follow the instructions below to install'
      redirect_to install_path
    end

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

  def new
    account_uid = params[:account]
    aa = Account.where(uid: account_uid)
    if aa.count > 0
      account_id = aa.first.id
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
          u = User.create(email: email, password: 'password123')
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

      render json: output
    else
      render json: {response: 'Error', message: 'The account ID is not recognized.', id: account_uid}
    end
  end

end
