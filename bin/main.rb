require 'telegram/bot'
token = '1015939462:AAH6wJmzjKT9z3AkP0g_3GlsOwVS0fGEEek'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
   pp message.text
  end
end
