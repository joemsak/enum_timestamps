require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#status" do
    it "is powered by enum" do
      user = create(:user)

      expect(user).to be_invited

      expect {
        user.pending!
      }.to change {
        user.status
      }.from("invited").to("pending")

      expect {
        user.approved!
      }.to change {
        User.approved.count
      }.from(0).to(1)
    end
  end
end
