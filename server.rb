require 'sinatra'
require 'action_mailer'
require 'letter_opener'
require './mailer_config'


 get '/' do
  send_file File.expand_path('index.html', settings.public_folder)
 end

 post '/' do
  Mailer.contact(params).deliver_now
 end
