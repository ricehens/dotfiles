sudo launchctl unload /System/Library/LaunchDaemons/com.apple.audio.coreaudiod.plist

sudo rm -rf /Library/Preferences/Audio/com.apple.audio.SystemSettings.plist
sudo rm -rf /Library/Preferences/Audio/com.apple.audio.DeviceSettings.plist

sudo rm -rv /Library/Preferences/com.apple.audio.DeviceSettings.plist
sudo rm -rv /Library/Preferences/com.apple.audio.SystemSettings.plist

sudo rm -rv ~/Library/Preferences/com.apple.audio.AudioMIDISetup.plist

sudo rm -rv ~/Library/Preferences/ByHost/com.apple.MIDI.0016174ee065.plist
sudo rm -rv '~/Library/Audio/MIDI Configurations/Default.mcfg'
