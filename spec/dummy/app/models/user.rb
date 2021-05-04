class User < ApplicationRecord
  enum status: %i[
    invited
    pending
    approved
    rejected
    deleted
  ]
end
