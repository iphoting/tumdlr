require 'rubygems'
require 'bundler'
Bundler.setup(:default, ENV['RACK_ENV'] || :production)

require 'sinatra'
require 'sinatra/multi_route'

require 'haml'
require 'rack-timeout'
require 'rack-flash'
require 'uri'
require 'addressable/uri'
require 'net/http'
require "#{File.dirname(__FILE__)}/tumblr-downloader"
require "#{File.dirname(__FILE__)}/youtube-downloader"

configure :production do
	require 'newrelic_rpm' if ENV["NEW_RELIC_LICENSE_KEY"] and ENV["NEW_RELIC_APP_NAME"]
	require 'rack/ssl-enforcer'
	use Rack::SslEnforcer, :hsts => true
end

use Rack::Timeout
Rack::Timeout.timeout = 10
use Rack::ConditionalGet
use Rack::ETag
use Rack::ContentLength
use Rack::Deflater

enable :sessions
use Rack::Flash

get '/' do
	if params[:url]
		redirect to("/url?url=#{params[:url]}")
	else
		@error = flash[:error] unless flash[:error].nil?
		@notice = flash[:notice] unless flash[:notice].nil?
		haml :form
	end
end

route :post, :get, '/url' do
	if params[:url].empty?
		flash[:error] = "No URL entered!"
		redirect to('/')
	elsif !valid_url?(params[:url])
		flash[:error] = "Invalid URL entered!"
		redirect to('/')
	end

	@source = params[:url]

	begin
		@url = get_youtube_dl_url(@source) || get_youtube_vid_url(@source) || get_tumblr_vid_url(@source)

		if @url.empty?
			flash[:error] = "No video file found!"
			redirect to('/')
		end
		haml :url
	rescue NoMethodError
		flash[:error] = "No video file found!"
		redirect to('/')
	end
end

def valid_url?(url)
  parsed = Addressable::URI.parse(url) or return false
  %w(http https).include?(parsed.scheme)
rescue Addressable::URI::InvalidURIError
  false
end
