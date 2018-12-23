require 'open-uri'

if Rails.env.production?
  Thread.new do
    loop do
      open('http://spacycrew.com').status
      sleep 3600
    end
  end
end
