# app/workers/beer_on_rails_worker.rb
class BeerOnRailsWorker
  include Sidekiq::Worker
  
  def perform
    puts "Beer, Beer, Beer on Rails..."
  end

end