require 'viddl-rb'

def get_youtube_vid_url (source = "")
	a = ViddlRb.get_urls(source)
	unless a.nil?
		return a.first
	else
		return nil
	end
end
