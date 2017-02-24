class CreditCard < ApplicationRecord
  belongs_to :account
  has_many :buys, dependent: :destroy
  validate :validate_last_four_digits, :validate_payment_day

  validates :account_id, presence: true
  validates :last_four_digits, presence: true, length: {is: 4}
  validates :name, presence: true, length: {minimum: 2, maximum: 20}
  validates :payment_day, presence: true

  private
    def validate_last_four_digits
      errors.add(:last_four_digits, "should be a number") unless last_four_digits_is_a_number?
    end

    def last_four_digits_is_a_number?
      self.last_four_digits.to_i.to_s == self.last_four_digits
    end

    def validate_payment_day
      errors.add(:payment_day, "should be a valid day") unless self.payment_day>0 && self.payment_day <=31
    end
end