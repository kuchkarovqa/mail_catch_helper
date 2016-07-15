# Mailcatcher ruby helper
Simple mailcatcher helper

## How:
```ruby
server = "http://localhost:64555"
mailcatcher = MailCatchHelper.new(server)
messages = mailcatcher.get_messages
message = mailcatcher.get_message_with_id(3)

message.id
message.sender
message.recipients
message.subject
message.created_at
message.body
```
