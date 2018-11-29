class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_insensitive: false}
  has_secure_password
  has_many :posts

  # To generate a random string
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # To create a hashed digest of a given string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password .create(string, cost: cost)
  end
end
