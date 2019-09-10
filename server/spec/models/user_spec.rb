require "rails_helper"

RSpec.describe User, type: :model do
  let(:valid_user) {build(:user)}

  describe "validation" do
    it "validates email correctly" do
      expect(valid_user.valid?).to eq true
      create(:user, email: "duplicate@example.com")

      invalid_emails = [
        nil,
        "",
        "this is not mail add",
        "duplicate@example.com",
      ]
      invalid_emails.each do |invalid_email|
        valid_user.email = invalid_email
        expect(valid_user.valid?).to eq false
      end
    end
  end
end
