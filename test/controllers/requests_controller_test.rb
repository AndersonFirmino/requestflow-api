require "test_helper"

class RequestsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = User.create!(
      email: "admin@example.com",
      password: "123456",
      password_confirmation: "123456",
      role: "admin"
    )

    @user = User.create!(
      email: "user@example.com",
      password: "123456",
      password_confirmation: "123456",
      role: "user"
    )

    @request = Request.create!(
      title: "PC novo",
      description: "Máquina travando demais",
      status: "pending",
      user: @user
    )
  end

  def auth_headers(user)
    token = JsonWebToken.encode(user_id: user.id)
    {
      "Authorization" => "Bearer #{token}",
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }
  end

  test "user can create a request" do
    post "/requests", params: {
      request: {
        title: "Teclado novo",
        description: "O meu quebrou"
      }
    }.to_json, headers: auth_headers(@user)

    assert_response :success
    json = JSON.parse(response.body)
    assert_equal "Teclado novo", json["title"]
  end

  test "admin can list all requests" do
    get "/requests", headers: auth_headers(@admin)

    assert_response :success
    json = JSON.parse(response.body)
    assert json.is_a?(Array)
  end

  test "admin can approve a request" do
    put "/requests/#{@request.id}/approve", headers: auth_headers(@admin)

    assert_response :success
    json = JSON.parse(response.body)
    assert_equal "approved", json["status"]
  end

  test "admin can reject a request" do
    put "/requests/#{@request.id}/reject", headers: auth_headers(@admin)

    assert_response :success
    json = JSON.parse(response.body)
    assert_equal "rejected", json["status"]
  end

  test "user cannot approve requests" do
    put "/requests/#{@request.id}/approve", headers: auth_headers(@user)

    assert_response :forbidden
  end
end
