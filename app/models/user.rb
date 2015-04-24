class User < ActiveRecord::Base
	has_many :reports
  attr_reader :password

  #This vaidates the name, email and password
  validates :name, presence: true #make sure name is present
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i } #make sure email is present, unique and in the correct format
  validates :password, presence: true, confirmation: true, length: { in: 6..20} #makes sure password is present, confirmed and 6 to 20 characters   


	def password=(unencrypted_password)
  		unless unencrypted_password.empty?
    	@password = unencrypted_password
    	self.password_digest = BCrypt::Password.create(unencrypted_password)
  	 end
  end

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(self.password_digest) == unencrypted_password
      return self
    else
      return false
    end
  end
end

