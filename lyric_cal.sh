#!/bin/bash
# Simple lyrics finder with playerctl
# Shows jcal if no song is playing.

statu="$(playerctl --ignore-player=chromium --ignore-player=vlc status)"

if [[ $statu == *"No players"* ]] || [[ $statu == *"Stop"* ]] || [[ $statu == *"Pause"* ]]
then
	echo -n "$(/usr/bin/jcal -e | tail -7 | $HOME/.local/bin/ansito - | sed -r 's: :  :g' | sed -r 's:\$\{color\s\s?black\}:\$\{color #00ffa8\}:' | sed -r 's:^:         :'  | sed '2s/.*/\ &/' |  sed '1s:^:\n:' )"
elif [[ $statu == *"Playing"* ]];
then
	LyricsAPI="https://makeitpersonal.co/lyrics/"
	Artist=$(playerctl metadata artist | sed -r 's:\s?(,|- ).*::')
	Title=$(playerctl metadata title | sed -r 's:\s?(,|- ).*::')
	Track="${Artist} - ${Title}"

	#curl -s --get "https://makeitpersonal.co/lyrics/" --data-urlencode "artist=$(playerctl metadata artist | sed -r 's:\s?(,|- ).*::')" --data-urlencode "title=$(playerctl metadata title | sed -r 's:\s?(,|- ).*::')" | sed -r '/^\s*$/d'
	# SED = DELET EMPTY LINES	
	Lyrics=$(curl -s --get "$LyricsAPI" --data-urlencode "artist=${Artist}" --data-urlencode "title=${Title}" | sed -r '/^\s*$/d' | sed -r 's:^:        :' ) 
	WCL=$(echo -n "$Lyrics" | wc -l)
	
	if [[ "$Lyrics" = "Invalid params" || "$Lyrics" = "No players found" || $Lyrics == *"Sorry, We don't have lyrics"* ]]; then
		echo -e "\n\nhmmm, not found :/"
	elif [[ $WCL -le 50 ]]; then
		echo "$Track" | sed '1s:^:\$\{alignc\}\$\{font Ani\:Bold\:size=13\}:'
		echo "$Lyrics" | sed '1s:^:\$\{font sans-serif\:normal\:size=8\}:'
	else
		echo -e "\n$Lyrics" | head -n 57 | sed "1s:^:\$\{alignc\}\$\{font sans-serif\:normal\:size=7\}:"

	fi
fi
