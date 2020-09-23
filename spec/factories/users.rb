FactoryBot.define do
  factory :user do
    password_digest { "MyString" }
    email { "MyString" }
    api_key { "MyString" }
  end
end
