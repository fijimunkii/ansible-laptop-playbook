#!/bin/sh
launchctl unload /System/Library/LaunchDaemons/com.apple.nsurlstoraged.plist 2>/dev/null
launchctl unload /System/Library/LaunchAgents/com.apple.nsurlsessiond.plist 2>/dev/null
sudo launchctl unload /System/Library/LaunchDaemons/com.apple.nsurlsessiond.plist 2>/dev/null
sudo launchctl unload /System/Library/LaunchDaemons/com.apple.nsurlstoraged.plist 2>/dev/null
