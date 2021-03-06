class Account < ApplicationRecord
  before_save :downcase_login_and_titleize_name

  has_many :credit_cards, dependent: :destroy
  has_many :users, dependent: :destroy

  validates :login, presence: true, length: {minimum: 4, maximum: 10},
            uniqueness: true
  validates :name, presence: true, length: {minimum: 2, maximum: 20}

  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }, allow_nil: true
  private
    def downcase_login_and_titleize_name
      self.login = self.login.downcase
      self.name = self.name.downcase.titleize
    end
end