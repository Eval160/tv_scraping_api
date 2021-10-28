ActionMailer::Base.smtp_settings = {
  address: "navet.o2switch.net",
  port: 26,
  domain: 'roomintouch.fr',
  user_name: ENV['EMAIL_ADDRESS'],
  password: ENV['EMAIL_APP_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}
