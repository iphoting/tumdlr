require 'viddl-rb'

def get_youtube_vid_url (source = "")
	ViddlRb.get_urls(source).first
end
