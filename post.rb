require 'http'
require 'json'

response = HTTP.post("https://slack.com/api/chat.postMessage", params: {
    token: ENV['SLACK_API_TOKEN'],
    channel: "#dev",
    text: "はじめまして！",
    as_user: true,
})
puts JSON.pretty_generate(JSON.parse(response.body))

