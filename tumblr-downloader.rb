require 'nokogiri'
require 'open-uri'

def get_tumblr_vid_url (source = "")
	iframe = Nokogiri::HTML(open(URI(source))) do |config|
		config.noerror
	end.at_css(".tumblr_video_container iframe[src]")['src']

	return Nokogiri::HTML(open(URI(iframe))) do |config|
		config.noerror
	end.at_css("video > source")['src']
end
