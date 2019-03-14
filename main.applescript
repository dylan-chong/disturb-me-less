(* Note: The user must set their Do Not Disturb Shortcut to Shift+Cmd+Opt+Ctrl+D for this to work *)

set workTimeLengthInSeconds to 60 * 10
set breakTimeLengthInSeconds to 60 * 1

on setDoNotDisturb(shouldBeOn)
	(* Note 1: The 1 after menu bar may need to be changed to 2 when using multiple monitors *)
	(* Note 2: For 10.11 and newer "NotificationCentre" is now spelled "Notification Centre"*)
	(* Note 3: The alert must be shown before toggling do not disturb mode, as doing the toggling requires pressing the option key, and we don't want to disturb the user's typing *)
	tell application "System Events"
		tell application process "SystemUIServer"
			try
				if exists menu bar item "Notification Centre, Do Not Disturb enabled" of menu bar 1 of application process "SystemUIServer" of application "System Events" then
					if not shouldBeOn then
						with timeout of 9.9999999999E+10 seconds
							beep 3
							display dialog "Time to check your notifications!" buttons {"OK"} default button 1
						end timeout
						key down shift
						key down command
						key down option
						key down control
						keystroke "d"
						key up shift
						key up command
						key up option
						key up control
					end if
				else
					if shouldBeOn then
						with timeout of 9.9999999999E+10 seconds
							beep 3
							display dialog "Start working!" buttons {"OK"} default button 1
						end timeout
						key down shift
						key down command
						key down option
						key down control
						keystroke "d"
						key up shift
						key up command
						key up option
						key up control
					end if
				end if
			on error message
				key up shift
				key up command
				key up option
				key up control
				display dialog "ERROR toggling Do Not Disturb: " & message
			end try
		end tell
	end tell
end setDoNotDisturb

repeat
	setDoNotDisturb(true)
	delay workTimeLengthInSeconds
	setDoNotDisturb(false)
	delay breakTimeLengthInSeconds
end repeat
