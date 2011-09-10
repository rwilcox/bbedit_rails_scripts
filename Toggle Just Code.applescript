tell application "BBEdit"
	tell window 1
		set show toolbar to (not show toolbar)
	end tell
end tell

tell application "System Events"
	tell process "BBEdit"
		tell menu bar 1
			try
				click menu item "Hide Files" of menu "View"
			on error
				click menu item "Show Files" of menu "View"
			end try
		end tell
	end tell
end tell