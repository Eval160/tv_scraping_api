class AlertMailer < ApplicationMailer
  default from: 'ecrepontvalentine@gmail.com'

  def program_scraping_error
    mail(to: "sylvaingaltier@roomintouch.fr", subject: "Le scraping des programmes n'a pas fonctionn√©")
    mail(to: "valentine@roomintouch.fr", subject: "Le scraping des programmes n'a pas fonctionn√©")

  end
end
