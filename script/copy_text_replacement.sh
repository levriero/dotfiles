#!/usr/bin/env bash

set -e

/usr/libexec/PlistBuddy -c "Merge text_replacement.plist NSUserDictionaryReplacementItems" ~/Library/Preferences/.GlobalPreferences.plist
