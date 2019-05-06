require 'slack-ruby-client'
require './gourmet'
require './message_analyzer'

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
  analyzer = MessageAnalyzer.new(pattern)
  p pattern === data.text

  if analyzer.match? data.text
    keyword = analyzer.get_keyword(data.text)
    puts "keyword: #{keyword}"
    if keyword.empty?
      client.message(channel: data.channel, text: 'お腹すいた？')
    else
      gourmet_search = Gourmet.new
      shop_list = gourmet_search.search(keyword)
      shop_list.each do |shop|
        text = "#{shop.name}\n#{shop.address}\n#{shop.url}"
        client.message(channel: data.channel, text: text)
      end
    end
  else
    puts 'not match.'
  end

end

client.on :close do |_data|
  puts 'Client is about to disconnect'
end

client.on :close do |_data|
  puts 'Client has disconnected succesfully!'
end

client.start!

