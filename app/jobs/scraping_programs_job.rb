class ScrapingProgramsJob < ApplicationJob
  require 'open-uri'
  require 'nokogiri'

  queue_as :default

  def perform(*args)
    url = "https://roomintouch.fr/wp-content/uploads/2021/09/xmltv.xml"
    # url = "http://xmltv.bigsb.fr/xmltv.xml"
    # url = 'https://xmltv.ch/xmltv/xmltv-complet.xml'
    # url = 'https://xmltv.ch/xmltv/xmltv-tnt.xml'
    xml = Nokogiri::XML(URI.open(url))
    programs = Hash.from_xml(xml.to_s)['tv']['programme']
    puts programs
    programs.each do |program|
      channel = Channel.find_by(telerama_id: program['channel'])
      next if !channel
      Program.create!(
        title: program['title'],
        sub_title: program['sub_title'],
        category: program['category'],
        start_time: program['start'].to_datetime,
        stop_time: program['stop'].to_datetime,
        description: program['desc'],
        duration: program['length'].to_i,
        channel: channel
        )
    end
  end
end
