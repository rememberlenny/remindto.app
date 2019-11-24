class TelemetryController < ApplicationController
  skip_authorization_check :only => :track

  def track
    render json: {text: 'success'}
  end
end
