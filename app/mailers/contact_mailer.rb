class ContactMailer < ApplicationMailer
  default to: -> {'admin@email.com'}

  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message
  
    mail(from: email, subject: "New message from #{@name}")
  end

end
