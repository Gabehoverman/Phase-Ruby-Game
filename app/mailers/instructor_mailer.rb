class InstructorMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.instructor_mailer.password_reset.subject
def password_reset(instructor)
  @instructor = instructor
  mail :to => instructor.email, :subject => "Password Reset for JMG"
end
 
 def registration_confirmation(instructor)
  @instructor = instructor
  mail :to => instructor.email, :subject => "Verify Email for JMG"
end
end
