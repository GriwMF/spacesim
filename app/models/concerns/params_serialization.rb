module ParamsSerialization
  extend ActiveSupport::Concern

  included do
    before_save :dump
    after_save :load
    after_find :load
  end

  # convert AR objects to string
  def dump
    params.transform_values! do |value|
      if value.is_a?(ActiveRecord::Base)
        value = "parsed:#{value.class}:#{value.id}"
      end
      value
    end
  end

  # load AR objects from string
  def load
    params.transform_values! do |value|
      if value.is_a?(String) && value.start_with?('parsed:')
        value = value.split(':')
        value = value[1].constantize.find(value[2])
      end
      value
    end
  end
end
