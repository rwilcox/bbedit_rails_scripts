tell application "BBEdit"
	--display dialog (clipping list's visible) as string
	if clipping list's visible then
		close clipping list
		close Unix filters list
		close scripts list
	else
		open clipping list
		open Unix filters list
		open scripts list
	end if
	
end tell
