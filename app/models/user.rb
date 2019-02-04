class User < ActiveRecord::Base
  before_save { email.downcase! }
  attr_accessor :remember_token
  has_secure_password
  has_many :posts, dependent: :destroy
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_token, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_token).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_token, nil)
  end
end
