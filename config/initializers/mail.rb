ActionMailer::Base.smtp_settings = {
  :address   => 'smtp.mandrillapp.com',
  :port      => 587,
  :user_name => 'developer@moorem.com',
  :password  => 'QriuPOoKpDbpcBo1RTKQvQ',
  :domain    => 'fitncute.com'
}
ActionMailer::Base.delivery_method = :smtp

MandrillMailer.configure do |config|
  config.api_key = 'QriuPOoKpDbpcBo1RTKQvQ'
end