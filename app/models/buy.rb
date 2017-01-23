class Buy < ApplicationRecord
  serialize :list_of_buyers, Hash

  validate :validate_positive_value, :validate_current_payment, :validate_total_payment,
           :validate_current_payment_lt_total_payment, :validate_list_of_buyers

  validates :purchase_date, presence: true
  validates :current_payment, presence: true
  validates :total_payment, presence: true
  validates :value, presence: true
  validates :description, presence: true, length: {maximum: 55}
  validates :list_of_buyers, presence: true
  validates :credit_card_id, presence: true

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
      errors.add(:list_of_buyers, "don't match with value") unless (self.list_of_buyers.map{|key,value| value}.reduce(:+)-value).abs < 0.05
    end
end