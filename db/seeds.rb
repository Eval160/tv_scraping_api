require 'open-uri'
require 'nokogiri'

puts 'Clean DB'
Program.destroy_all
Channel.destroy_all

puts 'Create channels'

url = 'https://xmltv.ch/xmltv/xmltv-complet.xml'
# url = 'https://xmltv.ch/xmltv/xmltv-tnt.xml'
xml = Nokogiri::XML(URI.open(url))
channels = Hash.from_xml(xml.to_s)['tv']['channel']
puts "Channels array:"
puts channels

channels.each do |chan|
  puts "******"
  puts chan
  Channel.create!(telerama_id: chan['id'], name: chan['display_name'], icon: chan['icon']['src'])
end
puts "Channels created"

puts 'Create programs'
ScrappingProgramsJob.perform_later

puts "Programs created"
