namespace :world do
  desc "TODO"
  task run: :environment do
    ActiveRecord::Base.transaction do
      WorldDatum.step.update!(value: WorldDatum.step_number + 1)
      Factory.find_each(&:step)
      Ship.find_each(&:step)
      Character.find_each(&:step)
    end
  end
end
