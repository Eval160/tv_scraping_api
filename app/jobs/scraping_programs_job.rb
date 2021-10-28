class ScrapingProgramsJob < ApplicationJob
  require 'open-uri'
  require 'nokogiri'

  queue_as :default

  def perform(*args)
    url = 'http://185.170.214.229/xmltv.xml'
    # url = 'https://xmltv.ch/xmltv/xmltv-complet_1jour.xml'
    xml = Nokogiri::XML(URI.open(url))

    programs = Hash.from_xml(xml.to_s)['tv']['programme']
    program_count_before_scraping = Program.count
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
    program_count_after_scraping = Program.count
    unless program_count_after_scraping > program_count_before_scraping
      AlertMailer.program_scraping_error.deliver_now
    end
  end
end
