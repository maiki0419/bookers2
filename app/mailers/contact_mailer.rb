class ContactMailer < ApplicationMailer
  default  form: "mastudamaiki@gmail.com"

  def send_mail(user,contact,title)
    @user = user
    @contact = contact
    mail to: user.email,subject: title

  end
end
