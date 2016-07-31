require 'nokogiri'
require 'open-uri'
require 'rest_client'
require 'json'

def get_tumblr_vid_url (source = "")
	begin
		iframe = Nokogiri::HTML(open(URI(source))) do |config|
			config.noerror
		end.at_css(".tumblr_video_container iframe[src]")['src']

		return Nokogiri::HTML(open(URI(iframe))) do |config|
			config.noerror
		end.at_css("video > source")['src']
	rescue
		return nil
	end
end

def get_youtube_dl_url(source = "", api_host = 'iphoting-yt-dl-api.herokuapp.com')
	begin
		response = RestClient.get "https://#{api_host}/api/info", {:accept => :json, :params => {
			:url => source, :flatten => 'True'
			}}
		case response.code
		when 200
			info = JSON.parse(response)
			return info["videos"][0]["url"] unless info["videos"][0]["url"].nil?
		else
			return nil
		end
	rescue
		return nil
	end
end
