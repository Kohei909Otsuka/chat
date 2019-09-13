require "rails_helper"

RSpec.describe "/rooms", type: :request do
  describe "GET /rooms" do
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

      @user.rooms << build_list(:room, 2)
    end

    it "returns 200 ok with rooms" do
      emulate_login(login_info[:email], login_info[:password])
      get "/rooms"
      expect(response).to have_http_status :ok
      json = parse_json(response)
      expect(json[:data].length).to eq 2
    end
  end
end
