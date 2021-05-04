class User < ApplicationRecord
  include EnumTimestamps

  enum status: %i[
    invited
    pending
    approved
    rejected
    deleted
  ]

  track_enum_changes :status
end
