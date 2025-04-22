require "test_helper"

class RequestTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      email: "request_tester@example.com",
      password: "123456",
      password_confirmation: "123456",
      role: "user"
    )

    @request = Request.new(
      title: "New keyboard",
      description: "The old one broke",
      status: "pending",
      user: @user
    )
  end

  test "is valid with valid attributes" do
    assert @request.valid?
  end

  test "is invalid without a title" do
    @request.title = nil
    assert_not @request.valid?
  end

  test "is invalid without a description" do
    @request.description = nil
    assert_not @request.valid?
  end

  test "is invalid without a user" do
    @request.user = nil
    assert_not @request.valid?
  end

  test "is invalid with invalid status" do
    assert_raises ArgumentError do
      @request.status = "archived"
    end
  end
end
