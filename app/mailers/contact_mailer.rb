class ContactMailer < ApplicationMailer
  default  

  def send_mail(user,contact,current_user,title)
    @user = user
    @contact = contact
    mail to: user.email,from: current_user.email,subject: title

  end
end
