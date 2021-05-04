require "enum_timestamps/version"
require "enum_timestamps/engine"

module EnumTimestamps
  extend ActiveSupport::Concern

  included do
    has_many :enum_timestamps,
      as: :model,
      class_name: "::EnumTimestamps::EnumTimestamp"
  end

  def track_enum_timestamps(field_name)
    enum_method = String(field_name).pluralize

    timestamp = enum_timestamps.find_or_initialize_by({
      field_name: field_name,
      identifier: self.class.send(enum_method)[send(field_name)]
    })

    if timestamp.new_record?
      timestamp.save
    elsif send("saved_change_to_#{field_name}?")
      timestamp.touch
    end
  end

  class_methods do
    def track_enum_changes(*enum_fields)
      enum_fields.each do |field_name|
        _track_enum_changes!(field_name)
        _define_tracker_methods(field_name)
      end
    end

    private
    def _track_enum_changes!(field_name)
      after_commit -> { track_enum_timestamps(field_name) }
    end

    def _define_tracker_methods(field_name)
      enum_method = String(field_name).pluralize

      send(enum_method).each do |name, identifier|
        define_method "#{name}_at" do
          if timestamp = enum_timestamps.find_by({
               field_name: field_name,
               identifier: identifier,
             })
            timestamp.updated_at
          else
            nil
          end
        end
      end
    end
  end
end
