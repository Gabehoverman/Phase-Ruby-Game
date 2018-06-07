class Instructor < ActiveRecord::Base
	
	has_secure_password
	has_many :students

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
	UN_REGEX = /\A(?=.*[a-z])[a-z\d]+\Z/i

# after_update :email_changed

before_create :confirmation_token

# validates :password,
#                    :length => {:within => 6..40}

	validates :username,
		:presence => true,
		:uniqueness => true,
		:case_sensitive => false,
		:length => { :maximum => 50 },
		:format => UN_REGEX

	validates_confirmation_of :password 

	validates :email,
		:presence => true,
		:length => { :maximum => 50 },
		:uniqueness => true,
		:case_sensitive => false,
		:format => EMAIL_REGEX

# private
# def email_changed
#   if email_changed?
#   	update_attribute :emailconfirmed, false

#   end
# end


before_create { generate_token(:auth_token) }

def send_password_reset
  generate_token(:password_reset_token)
  self.password_reset_sent_at = Time.zone.now
  save!
  InstructorMailer.password_reset(self).deliver_now
end

def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while Instructor.exists?(column => self[column])
end

def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
end

def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  def send_email_activate
  generate_token(:confirm_token)
  save!
  InstructorMailer.registration_confirmation(self).deliver_now
end

end