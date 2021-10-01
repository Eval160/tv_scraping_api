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

