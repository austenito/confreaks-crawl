require 'http'
require 'pry'

years = 2009..2015

years.each do |year|
  puts year.to_s.upcase
  videos = JSON.parse(HTTP.accept(:json).get("http://confreaks.tv/api/v1/events/goruco#{year}/videos.json").body.to_s)
  begin
  videos.each do |video|
    puts video['slug']
    puts video['image']
    puts "-"
    first_name = video['presenters'].first['first_name'].downcase
    last_name = video['presenters'].first['last_name'].downcase
    `mkdir #{year}`
    `wget #{video['image']} -O #{year}/#{first_name}-#{last_name}-video.jpg`
  end
  rescue
    puts 'failed to get' + first_name
  end
  puts "==============================="
end
