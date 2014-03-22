class UserMailer < ActionMailer::Base
  default :from => "hello@gloced.com"
  
  def welcome_message(user)
    @user = user
    attachments["logo.png"] = File.read("#{Rails.root}/public/images/logo.png")
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Registered")
  end
end