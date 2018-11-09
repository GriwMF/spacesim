namespace :world do
  desc "TODO"
  task run: :environment do
    ActiveRecord::Base.transaction do
    Factory.find_each(&:step)
    Ship.find_each(&:step)
      end
  end

end
