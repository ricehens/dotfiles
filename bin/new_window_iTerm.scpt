# new_window_iTerm.scpt
tell application "System Events"
    set isRunning to (count of (every process whose name is "iTerm2")) > 0
end tell
if isRunning then
    tell application "iTerm"
      set newWindow to (create window with default profile)
    end tell
else
    tell application "iTerm"
      launch
    end tell
end if
