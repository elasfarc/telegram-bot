require 'telegram/bot'
token = '1015939462:AAH6wJmzjKT9z3AkP0g_3GlsOwVS0fGEEek'

Telegram::Bot::Client.run(token) do |bot|
  # bot.listen do |message|
  # pp message.text
  # end
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "welcome, #{message.from.first_name}\n")
      bot.api.send_message(chat_id: message.chat.id, text: " Provide your pair in the form of the following:\n amount from to\n from to \n amount")
    else
      message.text

    end
  end
end
