module ParamsSerialization
  extend ActiveSupport::Concern

  included do
    attr_accessor :params

    before_save :dump
    after_save :load
    after_find :load
  end

  # convert AR objects to string
  def dump
    self.parsed_params = params.transform_values do |value|
      if value.is_a?(ActiveRecord::Base)
        value = "parsed:#{value.class}:#{value.id}"
      end
      value
    end
  end

  # load AR objects from string
  def load
    self.params = parsed_params.transform_values do |value|
      if value.is_a?(String) && value.start_with?('parsed:')
        value = value.split(':')
        value = value[1].constantize.find(value[2])
      end
      value
    end.deep_symbolize_keys
  end
end
