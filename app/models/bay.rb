class Bay < ApplicationRecord
  belongs_to :ship
  has_many :systems, class_name: "Facilities::System"

  def consume(resource, amount)
    decrement!(resource, amount) if send(resource) >= amount
  end

  def step
    # systems_step('generator')
    # systems_step('o2_gen')
    systems.find_each(&:step)
  end

  def status
    sys_status = systems.map { |s| { s.type => s.status }}
    { integrity: integrity, sys_status: sys_status }
  end

  private

  def systems_step(type)
    systems.where(type: type).find_each(&:step)
  end
end
