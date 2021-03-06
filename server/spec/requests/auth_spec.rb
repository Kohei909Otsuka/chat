require "rails_helper"

RSpec.describe "/auth" do
  describe "POST /login" do
    let(:login_info) do
      {
        name: "kohei",
        email: "kohei@example.com",
        password: "password-00"
      }
    end

    before do
      @user = User.register(
        login_info[:name],
        login_info[:email],
        login_info[:password]
      ).data

      allow(SecureRandom)
        .to receive(:uuid)
        .and_return("some-uuid")
    end

    it "returns 200 ok when found" do
      post "/login", params: {
        email: login_info[:email],
        password: login_info[:password]
      }

      expect(response)
        .to have_http_status :ok
      expect(response.header["Set-Cookie"])
        .to eq "session_id=some-uuid; path=/"
    end

    it "returns 404 when not found" do
      post "/login", params: {
        email: "extrat" + login_info[:email],
        password: login_info[:password]
      }

      expect(response)
        .to have_http_status :not_found
    end
  end
end
