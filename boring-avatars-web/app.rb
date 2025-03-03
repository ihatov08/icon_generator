require 'sinatra'
require 'net/http'
require 'uri'
require 'redis'

set :bind, '0.0.0.0'
redis = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'])

get '/' do
  "Hello, World!"
end

get '/identicon' do
  erb :index
end

post '/identicon' do
  @identicon = redis.get(params[:name])
  unless @identicon
    url = URI::HTTP.build({
      host: ENV['AVATAR_SERVICE_HOST'],
      port: ENV['AVATAR_SERVICE_PORT'],
      path: "/beam/80/#{params[:name]}"
    })
    @identicon = Net::HTTP.get(url)
    redis.set(params[:name], @identicon)
  end

  erb :index
end
