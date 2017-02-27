require 'test_helper'

class CreditCardTest < ActiveSupport::TestCase
  setup do
    @account = accounts(:jose)
  end

  test "should be valid" do
    cc = CreditCard.new(name: 'Marisa', payment_day: 1, last_four_digits: '1234', account_id: @account.id)
    assert cc.valid?
  end

  test "last_four_digits should be 4 characters" do
    cc = CreditCard.new(name: 'Marisa', payment_day: 1, last_four_digits: '12345', account_id: @account.id)
    assert_not cc.valid?
    assert_equal ["Last four digits is the wrong length (should be 4 characters)"], cc.errors.full_messages
  end

  test "last_four_digits should be present" do
    cc = CreditCard.new(name: 'Marisa', payment_day: 1, account_id: @account.id)
    assert_not cc.valid?
    assert_equal ["Last four digits should be a number", 
      "Last four digits can't be blank", 
      "Last four digits is the wrong length (should be 4 characters)"], cc.errors.full_messages
  end

  test "name should be unvalid" do
    cc = CreditCard.new(name: 'M', payment_day: 1, last_four_digits: '1234', account_id: @account.id)
    assert_not cc.valid?
    assert_equal ["Name is too short (minimum is 2 characters)"], cc.errors.full_messages

    cc = CreditCard.new(name: 'M'*21, payment_day: 1, last_four_digits: '1234', account_id: @account.id)
    assert_not cc.valid?
    assert_equal ["Name is too long (maximum is 20 characters)"], cc.errors.full_messages
  end

  test "name should be present" do
    cc = CreditCard.new(payment_day: 1, last_four_digits: '1234', account_id: @account.id)
    assert_not cc.valid?
    assert_equal ["Name can't be blank",
                  "Name is too short (minimum is 2 characters)"], cc.errors.full_messages
  end

  test "payment_day should be between 1 and 31" do
    cc = CreditCard.new(name: 'Marisa', payment_day: 0, last_four_digits: '1234', account_id: @account.id)
    assert_not cc.valid?
    assert_equal ["Payment day should be a valid day"], cc.errors.full_messages

    cc = CreditCard.new(name: 'Marisa', payment_day: 32, last_four_digits: '1234', account_id: @account.id)
    assert_not cc.valid?
    assert_equal ["Payment day should be a valid day"], cc.errors.full_messages
  end

  test "payment_day should be present" do
    cc = CreditCard.new(name: 'Marisa', last_four_digits: '1234', account_id: @account.id)
    assert_not cc.valid?
    assert_equal ["Payment day can't be blank"], cc.errors.full_messages
  end

  test "account_id should be present" do
    cc = CreditCard.new(name: 'Marisa', last_four_digits: '1234', payment_day: 1)
    assert_not cc.valid?
    assert_equal ["Account must exist", "Account can't be blank"], cc.errors.full_messages
  end
end