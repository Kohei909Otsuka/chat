FactoryBot.define do
  factory :user do
    name { "IronMan" }
    email { "ironman@example.com" }
    hashed_password do
     User.hash("password-00")
    end
  end
end
