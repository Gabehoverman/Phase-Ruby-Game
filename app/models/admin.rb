class Admin < ActiveRecord::Base
	
	has_secure_password

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

	validates :username,
		:presence => true,
		:uniqueness => true,
		:case_sensitive => false,
		:length => { :maximum => 50 }

	validates :email,
		:presence => true,
		:length => { :maximum => 50 },
		:uniqueness => true,
		:case_sensitive => false,
		:format => EMAIL_REGEX

end