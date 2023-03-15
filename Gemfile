source 'https://rubygems.org'

ruby File.read('.ruby-version', mode: 'rb').chomp
#ruby-gemset=tumdlr

gem 'rack', '>= 2.2.6.4'
gem 'rack-flash3'
gem 'rack-ssl-enforcer'
gem 'rack-timeout'

gem 'haml', "~> 5.2"
gem 'rdiscount'
gem 'sinatra', '~> 3.0', '>= 3.0.4'
gem 'sinatra-contrib'

gem 'addressable'
gem 'nokogiri'
gem 'rest-client'

group :production do
	gem 'newrelic_rpm'
	gem 'iodine', '~> 0.7'
end
