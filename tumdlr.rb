require 'rubygems'
require 'bundler'
Bundler.setup(:default, ENV['RACK_ENV'])

require 'sinatra'
require 'haml'
require 'rack-flash'
require 'uri'
require 'addressable/uri'
require 'net/http'
require "#{File.dirname(__FILE__)}/tumblr-downloader"


use Rack::ContentLength
use Rack::Deflater
use Rack::ConditionalGet

enable :sessions
use Rack::Flash

configure :production do
	require 'rack/ssl-enforcer'
	use Rack::SslEnforcer, :hsts => true
end

get '/' do
	@error = flash[:error] unless flash[:error].nil?
	@notice = flash[:notice] unless flash[:notice].nil?
	haml :form
end

get '/url' do
	redirect to('/')
end

post '/url' do
	if params[:url].empty?
		flash[:error] = "No URL entered!"
		redirect to('/')
	elsif !valid_url?(params[:url])
		flash[:error] = "Invalid URL entered!"
		redirect to('/')
	end

	begin
		@source = params[:url]
		@url = get_tumblr_vid_url(params[:url])

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
