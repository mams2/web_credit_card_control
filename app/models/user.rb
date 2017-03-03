class User < ApplicationRecord
  before_save :downcase_name
  before_destroy :destroy_buys
  after_update :uptade_buys
  belongs_to :account

  validates :account_id, presence: true
  validates :name, presence: true, length: {minimum: 2, maximum: 20}

  validates_uniqueness_of :name, scope: :account_id

  private
    def downcase_name
      self.name = self.name.downcase
    end

    def destroy_buys
      Buy.all.each do |buy|
        dependency = buy.list_of_buyers.detect{|name,value| self.name == name}
        buy.delete if dependency
      end
    end

    def uptade_buys
      teste = Buy.all.each do |buy|
        dependency = buy.list_of_buyers.detect{|name,value| self.name_was == name}
        if dependency
          buy.list_of_buyers[self.name] = buy.list_of_buyers.delete(self.name_was)
          buy.save
        end
      end
    end
end