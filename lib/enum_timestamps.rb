require "enum_timestamps/version"
require "enum_timestamps/engine"

module EnumTimestamps
  extend ActiveSupport::Concern

  autoload :Decorator, "enum_timestamps/decorator"

  included do
    has_many :enum_timestamps,
      as: :model,
      class_name: "::EnumTimestamps::EnumTimestamp"
  end

  private
  def track_enum_timestamps(field_name)
    _enum_timestamps_decorator.new(field_name, model: self).track_timestamp!
  end

  def _enum_timestamps_decorator
    self.class._enum_timestamps_decorator
  end

  class_methods do
    def track_enum_changes(*enum_fields)
      enum_fields.each do |field_name|
        after_commit -> { track_enum_timestamps(field_name) }
        _define_tracker_methods(field_name)
      end
    end

    def _enum_timestamps_decorator
      Decorator
    end

    private
    def _define_tracker_methods(field_name)
      tracker = _enum_timestamps_decorator.new(field_name, klass: self)

      tracker.enum_map.each do |name, identifier|
        define_method "#{name}_at" do
          _enum_timestamps_decorator.new(
            field_name,
            identifier: identifier,
            model: self
          ).timestamp_updated_at
        end
      end
    end
  end
end
