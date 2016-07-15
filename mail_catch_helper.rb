require 'net/http'
require 'json'

class MailCatchHelper
  MESSAGES = "/messages"

  def initialize(server)
    @server = server
  end

  def get_messages
    messages = []
    string = get_request("#{@server}/#{MESSAGES}")
    to_json(string).each {|message| messages.push(parse_message(message))}
    messages
  end

  def get_message_with_id(id)
    string = get_request("#{@server}/#{MESSAGES}/#{id}.json")
    json = to_json(string)
    parse_message(json)
  end

  private

  def parse_message(json)
    OpenStruct.new(id: json["id"],
                   sender:json["sender"],
                   recipients:json["recipients"],
                   subject:json["subject"],
                   created_at:json["created_at"],
                   body:get_message_body(json["id"]))
  end

  def get_message_body(id)
    get_request("#{@server}/#{MESSAGES}/#{id}.plain")
  end

  def get_request(url)
    uri = URI(url)
    Net::HTTP.get(uri)
  end

  def to_json(string)
    JSON.parse(string)
  end

end
