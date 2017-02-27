require 'test_helper'

class BuyTest < ActiveSupport::TestCase
  setup do
    @account = accounts(:jose)
    @cc = CreditCard.new(name: 'Marisa', payment_day: 1, last_four_digits: '1234', account_id: @account.id)
    @cc.save
    @user = User.new(name: 'jose', account_id: @account.id)
    @user.save
  end

  test "should be valid" do
    buy = Buy.new(purchase_date: Date.today, current_payment: 1, total_payment: 1, value: 100,
                 description: 'marisa.com', list_of_buyers: {'jose'=>100}, credit_card_id: @cc.id)
    assert buy.valid?
  end

  test "purchase_date should be present" do
    buy = Buy.new(current_payment: 1, total_payment: 1, value: 100,
                 description: 'marisa.com', list_of_buyers: {'jose'=>100}, credit_card_id: @cc.id)
    assert_not buy.valid?
    assert_equal ["Purchase date can't be blank"], buy.errors.full_messages
  end

  test "current_payment should be present" do
    buy = Buy.new(purchase_date: Date.today, total_payment: 1, value: 100,
                 description: 'marisa.com', list_of_buyers: {'jose'=>100}, credit_card_id: @cc.id)
    assert_not buy.valid?
    assert_equal ["Current payment can't be blank"], buy.errors.full_messages
  end

  test "current_payment should be valid" do
    buy = Buy.new(purchase_date: Date.today, current_payment: 0, total_payment: 1, value: 100,
                 description: 'marisa.com', list_of_buyers: {'jose'=>100}, credit_card_id: @cc.id)
    assert_not buy.valid?
    assert_equal ["Current payment should be greater than 0"], buy.errors.full_messages
  end

  test "total_payment should be present" do
    buy = Buy.new(purchase_date: Date.today, current_payment: 1, value: 100,
                 description: 'marisa.com', list_of_buyers: {'jose'=>100}, credit_card_id: @cc.id)
    assert_not buy.valid?
    assert_equal ["Total payment can't be blank"], buy.errors.full_messages
  end

  test "total_payment should be valid" do
    buy = Buy.new(purchase_date: Date.today, current_payment: 1, total_payment: 0, value: 100,
                 description: 'marisa.com', list_of_buyers: {'jose'=>100}, credit_card_id: @cc.id)
    assert_not buy.valid?
    assert_equal ["Total payment should be greater than 0", 
                  "Total payment should be greater or equal than current_payment"], buy.errors.full_messages
  end

  test "value should be present" do
    buy = Buy.new(purchase_date: Date.today, current_payment: 1, total_payment: 1,
                 description: 'marisa.com', list_of_buyers: {'jose'=>100}, credit_card_id: @cc.id)
    assert_not buy.valid?
    assert_equal ["Value can't be blank"], buy.errors.full_messages
  end

  test "value should be valid" do
    buy = Buy.new(purchase_date: Date.today, current_payment: 1, total_payment: 1, value: 0,
                 description: 'marisa.com', list_of_buyers: {'jose'=>0}, credit_card_id: @cc.id)
    assert_not buy.valid?
    assert_equal ["Value should be greater than 0.0"], buy.errors.full_messages
  end

  test "description should be present" do
    buy = Buy.new(purchase_date: Date.today, current_payment: 1, total_payment: 1, value: 100,
                  list_of_buyers: {'jose'=>100}, credit_card_id: @cc.id)
    assert_not buy.valid?
    assert_equal ["Description can't be blank"], buy.errors.full_messages
  end

  test "description should be valid" do
    buy = Buy.new(purchase_date: Date.today, current_payment: 1, total_payment: 1, value: 100,
                 description: 'a'*56, list_of_buyers: {'jose'=>100}, credit_card_id: @cc.id)
    assert_not buy.valid?
    assert_equal ["Description is too long (maximum is 55 characters)"], buy.errors.full_messages
  end

  test "list_of_buyers should be present" do
    buy = Buy.new(purchase_date: Date.today, current_payment: 1, total_payment: 1, value: 100,
                  description: 'marisa.com', credit_card_id: @cc.id)
    assert_not buy.valid?
    assert_equal ["List of buyers can't be blank"], buy.errors.full_messages
  end

  test "list_of_buyers should be valid" do
    buy = Buy.new(purchase_date: Date.today, current_payment: 1, total_payment: 1, value: 100,
                 description: 'marisa.com', list_of_buyers: {'jose'=>50}, credit_card_id: @cc.id)
    assert_not buy.valid?
    assert_equal ["List of buyers don't match with value"], buy.errors.full_messages

    buy = Buy.new(purchase_date: Date.today, current_payment: 1, total_payment: 1, value: 100,
                 description: 'marisa.com', list_of_buyers: {'joses'=>100}, credit_card_id: @cc.id)
    assert_not buy.valid?
    assert_equal ["List of buyers one or more users don't exist"], buy.errors.full_messages
  end

  test "credit_card_id should be present" do
    buy = Buy.new(purchase_date: Date.today, current_payment: 1, total_payment: 1, value: 100,
                 description: 'marisa.com', list_of_buyers: {'jose'=>100})
    assert_not buy.valid?
    assert_equal ["Credit card must exist", "Credit card can't be blank"], buy.errors.full_messages
  end
end