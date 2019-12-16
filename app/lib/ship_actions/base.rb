module ShipActions
  class Base
    # attrs = { a: 2, b: 3}
    # => @a = 2; @b = 3
    def initialize(**attrs)
      @attrs = attrs.keys
      @attrs.each do |attr|
        instance_variable_set(attr, attrs[attr])
      end
    end

    def dump(*@attrs)
      @attrs.map(&method(:instance_variable_get))
    end

    def step
      raise 'Not implemented'
    end
  end
end
