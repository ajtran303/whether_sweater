class User < ApplicationRecord
  after_create :set_api_key

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_secure_password

  private

  def set_api_key
    update(api_key: SecureRandom.uuid)
  end
end
