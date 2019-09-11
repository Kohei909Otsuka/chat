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

  describe "self.login" do
    let(:login_info) do
      {
        name: "kohei",
        email: "kohei@example.com",
        password: "password-00"
      }
    end

    before do
      User.register(
        login_info[:name],
        login_info[:email],
        login_info[:password]
      )
    end

    it "returns false when not found" do
      r = User.login("extra" + login_info[:email], login_info[:password])
      expect(r.success?).to eq false
    end

    it "returns user with session_id when not found" do
      r = User.login(login_info[:email], login_info[:password])
      expect(r.success?).to eq true
      expect(r.data.email).to eq login_info[:email]
      expect(r.data.session_id).not_to eq nil
    end
  end

  describe "logout" do
    let(:session_id) {"some-session-id"}
    before do
      @user = described_class
        .register("kohei", "kohei@example.com", "password-00")
        .data
      @user.session_id = session_id
      SessionStorage.set(session_id, @user.id)
    end

    it "return true and rm session when key found" do
      r = @user.logout
      expect(r.success?).to eq true
      expect(SessionStorage.get(session_id).data).to eq nil
    end
  end
end
