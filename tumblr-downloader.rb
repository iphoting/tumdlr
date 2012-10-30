def get_tumblr_vid_url (source = "")
	Net::HTTP.get(URI(source)).lines.grep(/video_file/i)[0].lines(' ').grep(/video_file/i)[0].gsub('\x22', '').gsub('src=', '')
end
