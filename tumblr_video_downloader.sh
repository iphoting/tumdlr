#!/usr/bin/env bash
#
# This scripts searches for a video_file link from the a Tumblr
#  video premalink page and uses wget to download the video file.
#

if [ -z "$1" ];
then
        echo "Usage: $0 <tumblr permalink URL>"
        exit 1
fi

set -e
set -o pipefail

URL=`curl -s -S -L "$1" | grep -i "video_file" | tr ' ' '\n' | grep -i video_file | sed 's|\\\\x22||g' | sed 's|^src=||g' `
echo "$URL"

#set -x
#wget --content-disposition -c "$URL"
#curl -L -C - -J -O "$URL"
