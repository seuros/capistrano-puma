require 'sinatra'

get '/' do
  'Hello, Puma'
end

run Sinatra::Application
