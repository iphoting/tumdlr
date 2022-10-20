source 'https://rubygems.org'

ruby File.read('.ruby-version', mode: 'rb').chomp
#ruby-gemset=tumdlr

gem 'rack'
gem 'rack-flash3'
gem 'rack-ssl-enforcer'
gem 'rack-timeout'

gem 'haml', "~> 5.2"
gem 'rdiscount'
gem 'sinatra', "~> 3.0"
gem 'sinatra-contrib'

gem 'addressable'
gem 'nokogiri', '>= 1.13.9'
gem 'rest-client'

group :production do
	gem 'newrelic_rpm'
	gem 'iodine', '~> 0.7'
end
