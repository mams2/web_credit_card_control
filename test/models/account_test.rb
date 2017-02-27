require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  
  test "should be valid" do
    account = accounts(:jose)
    assert account.valid?
  end

  test "login should be unique" do
    account = accounts(:jose)
    account2 = account.dup
    account.save
    assert_not account2.valid?
    assert_equal ["Login has already been taken"], account2.errors.full_messages
  end

  test "login should be present" do
    account = Account.new(name: 'teste', password: '1234', password_confirmation: '1234')
    assert_not account.valid?
    assert_equal ["Login can't be blank", 
                  "Login is too short (minimum is 4 characters)"], account.errors.full_messages
  end

  test "account login should be unvalid" do
    account = Account.new(login: 'te', name: 'teste', password: '1234', password_confirmation: '1234')
    assert_not account.valid?
    assert_equal ["Login is too short (minimum is 4 characters)"], account.errors.full_messages

    account = Account.new(login: 'a'*11, name: 'teste', password: '1234', password_confirmation: '1234')
    assert_not account.valid?
    assert_equal ["Login is too long (maximum is 10 characters)"], account.errors.full_messages
  end

  test "account name should be unvalid" do
    account = Account.new(login: 'teste', name: 't', password: '1234', password_confirmation: '1234')
    assert_not account.valid?
    assert_equal ["Name is too short (minimum is 2 characters)"], account.errors.full_messages

    account = Account.new(login: 'teste', name: 't'*21, password: '1234', password_confirmation: '1234')
    assert_not account.valid?
    assert_equal ["Name is too long (maximum is 20 characters)"], account.errors.full_messages
  end

  test "account name should be present" do
    account = Account.new(login: 'teste', password: '1234', password_confirmation: '1234')
    assert_not account.valid?
    assert_equal ["Name can't be blank",
                  "Name is too short (minimum is 2 characters)"], account.errors.full_messages
  end

  test "login should be save with downcase" do
    account = Account.new(login: 'TESTE', name: 'TESTE TESTE', password: '1234', password_confirmation: '1234')
    assert account.save
    assert_equal "teste", account.login
  end

  test "name should be save with titleize" do
    account = Account.new(login: 'TESTE', name: 'TESTE TESTE', password: '1234', password_confirmation: '1234')
    assert account.save
    assert_equal "Teste Teste", account.name
  end

  test "password don't should be match with password_confirmation" do
    account = Account.new(login: 'TESTE', name: 'TESTE TESTE', password: '1234', password_confirmation: '12345')
    assert_not account.valid?
    assert_equal ["Password confirmation doesn't match Password"], account.errors.full_messages
  end

end