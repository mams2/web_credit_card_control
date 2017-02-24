class User < ApplicationRecord
  before_save :downcase_name
  before_destroy :destroy_buys
  belongs_to :account

  validates :account_id, presence: true
  validates :name, presence: true, length: {minimum: 2, maximum: 20}

  validates_uniqueness_of :name, scope: :account_id

  private
    def downcase_name
      self.name = self.name.downcase
    end

    def destroy_buys
      Buy.all.each do |b|
        dependency = b.list_of_buyers.detect{|name,value| self.name == name}
        b.delete if dependency
      end
    end
end