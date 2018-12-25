require 'open-uri'

if Rails.env.production? && !$PROGRAM_NAME =~ /rake/
  Thread.new do
    loop do
      open('http://spacycrew.com').status
      sleep 600
    end
  end
end
