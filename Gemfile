source 'https://rubygems.org'

ruby File.read('.ruby-version', mode: 'rb').chomp
#ruby-gemset=tumdlr

gem 'rack'
gem 'rack-flash3'
gem 'rack-ssl-enforcer'
gem 'rack-timeout'

gem 'haml', "~> 5.2"
gem 'rdiscount'
gem 'sinatra', "~> 2.1"
gem 'sinatra-contrib'

gem 'addressable', '>= 2.8.0'
gem 'nokogiri'
gem 'rest-client'

group :production do
	gem 'newrelic_rpm'
	gem 'iodine', '~> 0.7'
end
