require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(
      email: "auth_test@example.com",
      password: "123456",
      password_confirmation: "123456",
      role: "user"
    )
  end

  test "should return token with valid credentials" do
    post "/auth/login", params: {
      email: @user.email,
      password: "123456"
    }, as: :json

    assert_response :success
    json = JSON.parse(response.body)
    assert json["token"].present?
    assert_equal @user.email, json["user"]["email"]
  end

  test "should return unauthorized with invalid password" do
    post "/auth/login", params: {
      email: @user.email,
      password: "wrongpass"
    }, as: :json

    assert_response :unauthorized
  end

  test "should return unauthorized with unknown email" do
    post "/auth/login", params: {
      email: "unknown@example.com",
      password: "123456"
    }, as: :json

    assert_response :unauthorized
  end
end
