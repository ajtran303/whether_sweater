FactoryBot.define do
  factory :user do
    email { 'unique_user@email.com' }
    api_key { 'SECURE API KEY' }
    password { 'SECURE PASSWORD'}
    password_confirmation { 'SECURE PASSWORD'}
  end
end
