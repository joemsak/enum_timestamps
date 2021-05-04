module EnumTimestamps
  class EnumTimestamp < ApplicationRecord
    self.table_name = :enum_timestamps

    belongs_to :model, polymorphic: true
  end
end
