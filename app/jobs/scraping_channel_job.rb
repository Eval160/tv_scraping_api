class ScrapingChannelJob < ApplicationJob
  require 'open-uri'
  require 'nokogiri'

  queue_as :default

  def perform(*args)
    url = "https://roomintouch.fr/wp-content/uploads/2021/09/xmltv.xml"
    xml = Nokogiri::XML(URI.open(url))
    channels = Hash.from_xml(xml.to_s)['tv']['channel']
    channels.each do |chan|
      Channel.create!(telerama_id: chan['id'], name: chan['display_name'], icon: chan['icon']['src'])
    end
  end
end
