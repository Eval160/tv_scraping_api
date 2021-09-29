require 'open-uri'
require 'nokogiri'

puts 'Clean DB'
Program.destroy_all
Channel.destroy_all

puts 'Create channels'

ScrapingChannelJob.perform_later

puts 'Channels created'

puts 'Create programs'

ScrapingProgramsJob.perform_later

puts 'Programs created'
