require 'rubygems'
require 'bundler'
Bundler.setup(:default, ENV['RACK_ENV'])

require 'sinatra'
require 'haml'
require 'shellwords'
require 'rack-flash'

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

post '/url' do
	if params[:url].empty?
		flash[:error] = "No URL entered!"
		redirect to('/')
	end
	cmd = "./tumblr_video_downloader.sh #{Shellwords.escape(params[:url])}"
	@url = `#{cmd}`
	#p @url

	if @url.empty?
		flash[:error] = "No video file found!"
		redirect to('/')
	end
	haml :url
end
