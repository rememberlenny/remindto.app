require 'test_helper'

class TelemetryControllerTest < ActionDispatch::IntegrationTest
  test "should get track" do
    get telemetry_track_url
    assert_response :success
  end

end
