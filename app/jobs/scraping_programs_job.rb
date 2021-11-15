class ScrapingProgramsJob < ApplicationJob
  require 'open-uri'
  require 'nokogiri'

  queue_as :default

  def perform(*args)
    url = 'http://185.170.214.229/xmltv.xml'
    # url = 'https://xmltv.ch/xmltv/xmltv-complet_1jour.xml'
    xml = Nokogiri::XML(URI.open(url))

    programs = Hash.from_xml(xml.to_s)['tv']['programme']
    programs.each do |program|
      channel = Channel.find_by(telerama_id: program['channel'])
      puts program_exist?(program)
      next if !channel || program_exist?(program)

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

    AlertMailer.program_scraping_error.deliver_now if Program.where("start_time > ?", Time.now.at_end_of_day).empty?
  end

  private

  def program_exist?(program)
    channel = Channel.find_by(telerama_id: program['channel'])
    Program.where(channel: channel).find_by(title: program['title'], start_time: program['start'].to_datetime, stop_time: program['stop'].to_datetime)
  end
end
