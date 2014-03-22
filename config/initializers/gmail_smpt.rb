ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
   :address              => "smtp.gmail.com",
   :port                 => 587,
   :user_name            => "hello@gloced.com",
   :password             => 'gl0c3d44',
   :authentication       => "plain",
   :enable_starttls_auto => true
 }
