require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get error" do
    get pages_error_url
    assert_response :success
  end

  test "should get rss" do
    get pages_rss_url
    assert_response :success
  end

  test "should get terms" do
    get pages_terms_url
    assert_response :success
  end

  test "should get privacy" do
    get pages_privacy_url
    assert_response :success
  end

  test "should get about" do
    get pages_about_url
    assert_response :success
  end

  test "should get optout" do
    get pages_optout_url
    assert_response :success
  end

  test "should get contract" do
    get pages_contract_url
    assert_response :success
  end

  test "should get dnt" do
    get pages_dnt_url
    assert_response :success
  end

  test "should get news" do
    get pages_news_url
    assert_response :success
  end

  test "should get pricing" do
    get pages_pricing_url
    assert_response :success
  end

  test "should get help" do
    get pages_help_url
    assert_response :success
  end

  test "should get howtouse" do
    get pages_howtouse_url
    assert_response :success
  end

  test "should get home" do
    get pages_home_url
    assert_response :success
  end

end
