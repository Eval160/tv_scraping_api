desc "This task is called by the Heroku scheduler add-on"

task :clean_programs => :environment do
  puts "Clean old programs..."
  CleanProgramsJob.perform_later
  puts "done."
end

task :scrape_programs => :environment do
  puts "Scrape new programs..."
  ScrapingProgramsJob.perform_later
  puts "done."
end


task :check_programs_scraping => :environment do
  puts "Check if the program's scraping worked well"
  if Program.where("start_time > ?", Time.now + 24.hours).empty?
    puts "Error with the scraping"
    AlertMailer.program_scraping_error.deliver_now
    puts "Email sent"
  else
    puts "Everything's ok"
  end
end
