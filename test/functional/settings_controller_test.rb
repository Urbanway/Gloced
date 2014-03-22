require 'test_helper'

class SettingsControllerTest < ActionController::TestCase
  test "should get account" do
    get :account
    assert_response :success
  end

  test "should get password" do
    get :password
    assert_response :success
  end

  test "should get notifications" do
    get :notifications
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

end
