class CreditCard < ApplicationRecord
  belongs_to :account
  validate :validate_last_four_digits

  validates :account_id, presence: true
  validates :last_four_digits, presence: true, length: {is: 4}
  validates :name, presence: true, length: {minimum: 2, maximum: 20}
  validates :payment_date, presence: true

  private
    def validate_last_four_digits
      errors.add(:last_four_digits, "should be a number") unless last_four_digits_is_a_number?
    end

    def last_four_digits_is_a_number?
      self.last_four_digits.to_i.to_s == self.last_four_digits
    end
end