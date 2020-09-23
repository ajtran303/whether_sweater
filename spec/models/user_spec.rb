require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:password_confirmation)}
  end

  it 'api_key generation on create' do
    user = User.create!(email: 'my@email.com', password: 'password', password_confirmation: 'password')
    expect(user.api_key).to_not be_nil
    expect(user.api_key).to be_a String
  end
end
