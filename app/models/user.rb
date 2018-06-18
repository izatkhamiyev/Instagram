class User < ApplicationRecord
	has_secure_password
	validates :username, presence: true, length: {maximum: 30 }, uniqueness: {case_sensative: false}
	validates :email, presence: true, uniqueness: {case_sensative: false}
 	validates :password, length: {minimum: 6, maximum: 30}
	validates_email_format_of :email, message: 'The e-mail format is not correct!'
	validates :username, :password, format: { with: /\A[0-9a-zA-Z_.\-]+\Z/, message: "Only alphanumeric characters, and -_."}
end
