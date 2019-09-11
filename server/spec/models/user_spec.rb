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

  describe "self.register" do
    it "returns true when nothing wrong" do
      r = User.register(
        "kohei",
        "kohei@example.com",
        "password-00"
      )
      pre_caled_hash =
        Digest::SHA256::hexdigest("password-00")

      expect(r.success?).to eq true
      user = r.data
      expect(user.id).not_to eq nil
      expect(user.hashed_password)
        .to eq pre_caled_hash
    end

    it "returns false when password invalid" do
      invalid_password = [
        nil,
        "1234-5678",
        "abcd-efgh",
        "abcd0efgh",
        "明日晴れるかな",
        "short"
      ]

      invalid_password.each do |pass|
        r = User.register(
        "kohei",
        "kohei@example.com",
         pass
        )

        expect(r.success?).to eq false
      end
    end

    it "returns false when user invalid" do
      not_mail_add = "koheiexample.com"

      r = User.register(
        "kohei",
        not_mail_add,
        "password-00"
      )
      expect(r.success?).to eq false
    end
  end
end
