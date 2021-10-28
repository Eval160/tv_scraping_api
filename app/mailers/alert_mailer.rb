class AlertMailer < ApplicationMailer
  default from: 'ecrepontvalentine@gmail.com'

  def program_scraping_error
    mail(to: "ecrepontvalentine@gmail.com", subject: "Le scraping des programmes n'a pas fonctionné")
  end
end
