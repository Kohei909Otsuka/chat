require "rails_helper"

RSpec.describe "/users", type: :request do
  describe "POST /users" do
   it "returns 200 ok when valid" do
     post "/users", params: {
       name: "kohei",
       email: "kohei@example.com",
       password: "password-00"
     }
     expect(response).to have_http_status :ok
     json = parse_json(response)
     attrs = json[:data][:attributes]
     expect(attrs[:name]).to eq "kohei"
     expect(attrs[:email]).to eq "kohei@example.com"
   end

   it "returns 422 when invalid" do
     post "/users", params: {}
     expect(response)
       .to have_http_status :unprocessable_entity
   end
  end
end
