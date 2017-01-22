class User < ApplicationRecord
  belongs_to :account

  validates :account_id, presence: true
  validates :name, presence: true, length: {minimum: 2, maximum: 20}

  validates_uniqueness_of :name, scope: :account_id
end