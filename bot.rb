require 'slack-ruby-client'
require './gourmet'

def search(keyword)
  gourmet = Gourumet.new
  gourmet.search(keyword)
end

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::INFO
  raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfuly connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com"
end

client.on :message do |data|
  puts data

  client.typing channel: data.channel

  pattern = /^ご飯[[:space:]|\s]*/

  p pattern === data.text
  if pattern === data.text
    keyword = pattern.match(data.text).post_match
    puts "keyword: #{keyword}"
    if keyword.empty?
      client.message(channel: data.channel, text: 'お腹すいた？')
    else
      shop_list = search(keyword)
      shop_list.each do |shop|
        text = "#{shop.name}\n#{shop.address}\n#{shop.url}"
        client.message(channel: data.channel, text: text)
      end
    end
  else
    puts 'not match.'
  end

=begin
  case data.text
  when 'ご飯' then
    results = search
    
    results.each do |result|
      client.message(channel: data.channel, text: result.name)
    end
  end
=end

end

client.on :close do |_data|
  puts 'Client is about to disconnect'
end

client.on :close do |_data|
  puts 'Client has disconnected succesfully!'
end

client.start!

