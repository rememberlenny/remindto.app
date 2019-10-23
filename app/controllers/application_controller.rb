class ApplicationController < ActionController::Base

  include Mengpaneel::Controller

  if ENV['BASIC_AUTH']
    user, pass = ENV['BASIC_AUTH'].split(':')
    http_basic_authenticate_with name: user, password: pass
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # Devise, require authenticate by default
  before_filter :authenticate_user!

  before_action :setup_mixpanel

  # CanCan, check authorization unless authorizing with devise
  check_authorization unless: :skip_check_authorization?

  # Special handling for ajax requests.
  # Must appear before other rescue_from statements.
  rescue_from Exception, with: :handle_uncaught_exception

  include CommonHelper
  include ErrorReportingConcern
  include AuthorizationErrorsConcern

  def check_accounts
    if !@current_user.nil? && !@current_user.account_id.nil?
        @current_account = Account.find(@current_user.account_id)
        @current_accounts = Account.where(owner_id: @current_user.account_id)
    end
  end

  protected

  def skip_check_authorization?
    devise_controller? || is_a?(RailsAdmin::ApplicationController)
  end

  def add_allow_credentials_headers
    # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS#section_5
    #
    # Because we want our front-end to send cookies to allow the API to be authenticated
    # (using 'withCredentials' in the XMLHttpRequest), we need to add some headers so
    # the browser will not reject the response
    response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
  end

  def options
    head :status => 200, :'Access-Control-Allow-Headers' => 'accept, content-type'
  end

  # Reset response so redirect or render can be called again.
  # This is an undocumented hack but it works.
  def reset_response
    self.instance_variable_set(:@_response_body, nil)
  end

  # Respond to uncaught exceptions with friendly error message during ajax requets
  def handle_uncaught_exception(exception)
    if request.format == :js
      report_error(exception)
      flash.now[:error] = Rails.env.development? ? exception.message : I18n.t('errors.unknown')
      render 'layouts/uncaught_error.js'
    else
      raise
    end
  end


  private
    def setup_mixpanel
      return unless user_signed_in?

      # For technical reasons, you need to do setup from a `mengpaneel.setup` block.
      # I'll go into those reasons later.
      mengpaneel.setup do
        mixpanel.identify(current_user.id)

        mixpanel.people.set(
          "ID"              => current_user.id,
          "$email"          => current_user.email,
          "$first_name"     => current_user.first_name,
          "$last_name"      => current_user.last_name,
          "$created"        => current_user.created_at,
          "$last_login"     => current_user.current_sign_in_at
        )
      end
    end
end
