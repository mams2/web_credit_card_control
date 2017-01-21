class Account < ApplicationRecord
  before_save :downcase_login_and_titleize_name
  validates :login, presence: true, length: {minimum: 4, maximum: 10},
            uniqueness: true
  validates :name, presence: true, length: {minimum: 2, maximum: 20}

  private
    def downcase_login_and_titleize_name
      self.login = self.login.downcase
      self.name = self.name.downcase.titleize
    end
end