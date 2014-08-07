#!/usr/bin/env bash

set -e

/usr/libexec/PlistBuddy -x -c "Print NSUserDictionaryReplacementItems" ~/Library/Preferences/.GlobalPreferences.plist > text_replacement.plist
