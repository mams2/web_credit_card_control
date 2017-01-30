class Buy < ApplicationRecord
  serialize :list_of_buyers, Hash

  validates :purchase_date, presence: true
  validates :current_payment, presence: true
  validates :total_payment, presence: true
  validates :value, presence: true
  validates :description, presence: true, length: {maximum: 55}
  validates :list_of_buyers, presence: true
  validates :credit_card_id, presence: true

  validate :validate_positive_value, :validate_current_payment, :validate_total_payment,
           :validate_current_payment_lt_total_payment, :validate_list_of_buyers

  private
    def validate_positive_value
      errors.add(:value, "should be greater than 0.0") unless self.value > 0.0
    end

    def validate_current_payment
      errors.add(:current_payment, "should be greater than 0") unless self.current_payment > 0.0
    end

    def validate_total_payment
      errors.add(:total_payment, "should be greater than 0") unless self.total_payment > 0.0
    end

    def validate_current_payment_lt_total_payment
      errors.add(:total_payment, "should be greater or equal than current_payment") unless self.current_payment <= self.total_payment
    end

    def validate_list_of_buyers
      return if self.list_of_buyers.blank?
      errors.add(:list_of_buyers, "don't match with value") unless (self.list_of_buyers.map{|key,value| value}.reduce(:+)-value).abs < 0.05
      debugger
      errors.add(:list_of_buyers, "one or more users don't exist") unless self.list_of_buyers.all?{|key,value| !User.find_by(account_id: fetch_account_id, name: key).nil?}
    end

    def fetch_account_id
      CreditCard.find_by(id: self.credit_card_id).account_id unless CreditCard.find_by(id: self.credit_card_id).nil?
    end
end
