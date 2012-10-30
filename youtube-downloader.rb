require 'youtube-downloader/youtube'

def get_youtube_vid_url (source = "")
	Youtube::Video.new(source).url
end
