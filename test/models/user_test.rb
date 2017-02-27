require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @account = accounts(:jose)
  end

  test "should be valid" do
    user = User.new(name: "teste", account_id: @account.id)
    assert user.valid?
  end

  test "name should be present" do
    user = User.new(account_id: @account.id)
    assert_not user.valid?
    assert_equal ["Name can't be blank",
                  "Name is too short (minimum is 2 characters)"], user.errors.full_messages
  end

  test "user name should be unvalid" do
    user = User.new(name: "t", account_id: @account.id)
    assert_not user.valid?
    assert_equal "Name is too short (minimum is 2 characters)", user.errors.full_messages.first

    user = User.new(name: "t"*21, account_id: @account.id)
    assert_not user.valid?
    assert_equal "Name is too long (maximum is 20 characters)", user.errors.full_messages.first
  end

  test "name should be unique by account" do
    user = User.new(name: "teste", account_id: @account.id)
    user.save
    user2 = user.dup
    assert_not user2.save
    assert_equal ["Name has already been taken"], user2.errors.full_messages
    
    account2 = accounts(:pedro)
    user2 = User.new(name: "teste", account_id: account2.id)
    assert user2.valid?
  end

  test "account id should be present" do
    user = User.new(name: "teste")
    assert_not user.valid?
    assert_equal ["Account must exist", "Account can't be blank"], user.errors.full_messages
  end

end