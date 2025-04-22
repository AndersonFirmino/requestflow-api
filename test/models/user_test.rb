require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: "test@example.com",
      password: "123456",
      password_confirmation: "123456",
      role: "admin"
    )
  end

  test "is valid with valid attributes" do
    assert @user.valid?
  end

  test "is invalid without an email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "is invalid with duplicated email" do
    @user.save
    user2 = User.new(
      email: "test@example.com",
      password: "123456",
      password_confirmation: "123456",
      role: "user"
    )
    assert_not user2.valid?
  end

  test "raises error with invalid role" do
    assert_raises ArgumentError do
      @user.role = "ninja"
    end
  end

  test "authenticates with correct password" do
    @user.save
    assert @user.authenticate("123456")
  end

  test "does not authenticate with incorrect password" do
    @user.save
    assert_not @user.authenticate("wrongpass")
  end
end
