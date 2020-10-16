require 'telegram/bot'
require_relative '../lib/currency_converter.rb'
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
        input = message.text
        pp input
        converter = CurrencyConverter.new(input)
        text = converter.converter_format
        #text = text.map(&:inspect).join(', ')
        #bot.api.send_message(chat_id: message.chat.id, text: text)
        text.each { |txt| bot.api.send_message(chat_id: message.chat.id, text: txt) }
        #bot.api.send_message(chat_id: message.chat.id, text: text)

    end
  end
end
