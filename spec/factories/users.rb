FactoryBot.define do
  factory :user do
    password_digest { "SECURE PASSWORD" }
    email { "unique_user@email.com" }
    api_key { "SECURE API KEY" }
  end
end
