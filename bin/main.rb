require 'telegram/bot'
require_relative '../lib/currency_converter.rb'
token = '1015939462:AAH6wJmzjKT9z3AkP0g_3GlsOwVS0fGEEek'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "welcome, #{message.from.first_name}\n")
      bot.api.send_message(chat_id: message.chat.id, text: ' Provide your pair in the form of the following:')
      bot.api.send_message(chat_id: message.chat.id, text: ' [Amount] [currencies pairs]')
      bot.api.send_message(chat_id: message.chat.id, text: 'currencies pairs = (base currency)(one or more quotes)')
      bot.api.send_message(chat_id: message.chat.id, text: 'all arguments are optional')
      bot.api.send_message(chat_id: message.chat.id, text: 'Deafault amount-> 1.0 Deafult BASE->USD')
    else
      input = message.text
      pp input
      begin
        converter = CurrencyConverter.new(input)
      rescue StandardError
        invalid_input = true
      end
      if invalid_input
        bot.api.send_message(chat_id: message.chat.id, text: 'check the amount again!')
      else
        pp converter.interpreted_input
        text = converter.converter_format
        pp converter.pairs
        text.each { |txt| bot.api.send_message(chat_id: message.chat.id, text: txt) }
      end

    end
  end
end
