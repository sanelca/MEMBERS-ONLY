
class User < ActiveRecord::Base
  attr_accessor :remember_token

	before_create { self.remember_token = digest(new_token) }

	has_many :posts, dependent: :destroy

	validates :username, presence: true
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
     validates :email, presence: true, length: { maximum: 255 },
                       format: { with: VALID_EMAIL_REGEX },
                       uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
	has_secure_password

	def new_token
		SecureRandom.urlsafe_base64
	end

	def digest(token)
		Digest::SHA1.hexdigest(token)
	end

	def remember
		self.remember_token = new_token
		update_attribute(:remember_token, digest(remember_token))
	end

	def forget
		update_attribute(:remember_token, nil)
	end
end
