require 'rails_helper'

module EnumTimestamps
  RSpec.describe EnumTimestamp, type: :model do
    describe "#<enum_field_identifier>_at" do
      it "manages them automatically" do
        freeze_time do
          user = build(:user)

          expect {
            user.save
          }.to change {
            User.last&.invited_at
          }.from(nil).to(Time.current)

          expect {
            user.pending!
          }.to change {
            User.last.pending_at
          }.from(nil).to(Time.current)
        end
      end
    end
  end
end
