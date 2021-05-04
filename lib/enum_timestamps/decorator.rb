module EnumTimestamps
  class Decorator
    attr_reader :model, :field_name, :klass

    def initialize(field_name, identifier: nil, model: nil, klass: nil)
      @field_name = String(field_name)
      @model = model
      @klass = klass || model.class
      @identifier = identifier
    end

    def enum_map
      klass.send(field_name.pluralize)
    end

    def current_value
      model.send(field_name)
    end

    def identifier
      @identifier || enum_map[current_value]
    end

    def track_timestamp!
      if guaranteed_timestamp.new_record?
        guaranteed_timestamp.save
      elsif track_change?
        guaranteed_timestamp.touch
      end
    end

    def timestamp_updated_at
      timestamp&.updated_at
    end

    def timestamp
      @ts ||= get_timestamp
    end

    private
    def guaranteed_timestamp
      @gts ||= @ts ||= get_timestamp(guaranteed: true)
    end

    def track_change?
      model.send("saved_change_to_#{field_name}?")
    end

    def get_timestamp(guaranteed: false)
      model.enum_timestamps.send(
        guaranteed ? :find_or_initialize_by : :find_by,
        field_name: field_name,
        identifier: identifier
      )
    end
  end
end
