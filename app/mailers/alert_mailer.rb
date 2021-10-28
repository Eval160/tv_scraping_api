class AlertMailer < ApplicationMailer
  default from: 'alert@ritmobile.com'

  def program_scraping_error
    mail(to: "ecrepontvalentine@hotmail.fr", subject: "Le scraping des programmes n'a pas fonctionné")
  end
end
