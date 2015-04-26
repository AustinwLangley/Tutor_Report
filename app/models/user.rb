class User < ActiveRecord::Base
	has_many :reports #this sets up a relationship with the report model where a User has many reports.  
  attr_reader :password #Sets up an @password instance variable and a password getter method

  #This vaidates the name, email and password
  validates :name, presence: true #make sure name is present
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i } #make sure email is present, unique and in the correct format
  validates :password, presence: true, confirmation: true, length: { in: 6..20}, on: :create #makes sure password is present, confirmed and 6 to 20 characters   

	def password=(unencrypted_password) #setter method for password.
    unless unencrypted_password.empty? #if there is no password, take the inputed password, salt and hash it.  Then set it in the record for that user.  
    @password = unencrypted_password
    self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def authenticate(unencrypted_password) #this method authenticates the password attempt.
    if BCrypt::Password.new(self.password_digest) == unencrypted_password
      return self
    else
      return false
    end
  end
end #end of the user model.  





  