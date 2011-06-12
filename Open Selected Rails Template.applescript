to getContainerOfFile(daPath)
	tell application "System Events"
		return POSIX path of container of daPath
	end tell
end getContainerOfFile

to removeExtensionAndControllerPrefix(filename)
	set ofs to offset of "." in filename
	set output to ""
	if ofs > 0 then
		set output to (characters 1 thru (ofs - 1) of filename) as string
		--set extension to (characters ofs thru (ofs + 3) of filename) as string
	else
		set output to filename
	end if
	
	set controllerOff to offset of "_" in output
	set output to (characters 1 through (controllerOff - 1) of output) as string
	return output
end removeExtensionAndControllerPrefix

to getRailsRoot(bbedit_project_window)
	local project_file
	tell application "BBEdit" to set project_file to file of «class GrpD» of bbedit_project_window
	
	return POSIX path of (getContainerOfFile(project_file))
end getRailsRoot

to findViewFiles()
	tell application "BBEdit"
		set view_partial_name to (get «class pusl») as string
		
		set controller_name_ext to (name of «class ADoc» of «class GrpW» 1) as string
		tell me to set controller_name to removeExtensionAndControllerPrefix(controller_name_ext)
		
		set project_win to «class GrpW» 1
		tell me to set rails_root to getRailsRoot(project_win)
		
		set controller_root to rails_root & "/app/views/" & controller_name & "/"
		
		set foundFiles to (do shell script "ls " & controller_root & view_partial_name & ".*")
		set oldDelim to AppleScript's text item delimiters
		set AppleScript's text item delimiters to return
		set foundFilesAsList to every text item of foundFiles
		set AppleScript's text item delimiters to oldDelim
		return foundFilesAsList
	end tell
end findViewFiles

to openInBBEdit(filePath)
	tell application "BBEdit" to open ((POSIX file filePath) as alias)
end openInBBEdit

on run {}
	set ourFiles to findViewFiles()
	if (count of ourFiles) is 1 then
		openInBBEdit(item 1 of ourFiles)
	end if
end run