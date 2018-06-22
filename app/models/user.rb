class User < ApplicationRecord
	attr_accessor :remember_token
	has_secure_password
	has_one_attached :avatar
	has_many :posts
	has_many :likes
	
	validates :username, presence: true, length: {maximum: 30 }, uniqueness: {case_sensative: false}
	validates :email, presence: true, uniqueness: {case_sensative: false}
 	validates :password, length: {minimum: 6, maximum: 30}
	validates_email_format_of :email, message: 'The e-mail format is not correct!'
	validates :username, :password, format: { with: /\A[0-9a-zA-Z_.\-]+\Z/, message: "Only alphanumeric characters, and -_."}

	before_save { self.email = email.downcase }
	before_save { self.username = username.downcase }

	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end

	def User.new_token
    	SecureRandom.urlsafe_base64
  	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end
	
	def authenticated?(remember_token)
    	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  	end
  	def forget
    	update_attribute(:remember_digest, nil)
 	end

end
