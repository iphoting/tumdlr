require 'viddl-rb'

def get_youtube_vid_url (source = "")
	begin
		a = ViddlRb.get_urls(source)
	rescue ViddlRb::DownloadError
		a = nil
	rescue ViddlRb::PluginError
		a = nil
	end

	unless a.nil?
		return a.first
	else
		return nil
	end
end
