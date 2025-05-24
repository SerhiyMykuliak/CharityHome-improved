class ContactsController < ApplicationController

  def create
    name = params[:name]
    email = params[:email]
    message = params[:message]

    if name.present? && email.present? && message.present?
      ContactMailer.contact_email(name, email, message).deliver_now
      flash[:notice] = "Message sent successfuly"
    else
      flash[:error] = "Please fill in all fields"
    end

    redirect_back fallback_location: root_path
  end

end
