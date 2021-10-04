class ScrapingChannelJob < ApplicationJob
  require 'open-uri'
  require 'nokogiri'

  queue_as :default

  def perform(*args)
    url = 'http://185.170.214.229/xmltv.xml'
    # url = 'https://xmltv.ch/xmltv/xmltv-complet_1jour.xml'
    xml = Nokogiri::XML(URI.open(url))
    channels = Hash.from_xml(xml.to_s)['tv']['channel']
    channels.each do |chan|
      Channel.create!(telerama_id: chan['id'], name: chan['display_name'], icon: chan['icon']['src'])
    end
  end
end
