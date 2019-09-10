FactoryBot.define do
  factory :user do
    name { "IronMan" }
    email { "ironman@example.com" }
    hashed_password do
     Digest::SHA256.hexdigest("password-00")
    end
  end
end
