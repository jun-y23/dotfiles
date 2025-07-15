#!/bin/bash

echo "macOSの設定を開始します..."

# --- トラックパッド ---
echo "トラックパッドの速さを最大に設定"
defaults write -g com.apple.trackpad.scaling 3

# --- Keyboard ---
echo "キーのリピート速度"
defaults write NSGlobalDomain KeyRepeat -int 2
echo "キーのリピート認識時間"
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "本体キーボードのCapsLockキーの動作をControlにリマップ"
keyboard_id="$(ioreg -c AppleEmbeddedKeyboard -r | grep -Eiw "VendorID|ProductID" | awk '{ print $4 }' | paste -s -d'-\n' -)-0"
defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_id} -array-add "
<dict>
  <key>HIDKeyboardModifierMappingDst</key>\
  <integer>30064771300</integer>\
  <key>HIDKeyboardModifierMappingSrc</key>\
  <integer>30064771129</integer>\
</dict>
"

# --- Finder ---
echo "隠しファイルを表示"
defaults write com.apple.finder AppleShowAllFiles -bool true
echo "パスバーを表示"
defaults write com.apple.finder ShowPathbar -bool true

# --- Dock ---
echo "Dockからすべてのアプリを消す"
defaults write com.apple.dock persistent-apps -array
echo "Dockを自動的に隠す"
defaults write com.apple.dock autohide -bool true

# --- スクリーンショット ---
echo "スクリーンショットの保存場所を~/Pictures/Screenshotsに変更"
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location ~/Pictures/Screenshots

# --- Battery ---
echo "バッテリを%表示"
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

## スクロールの方向
defaults write -g com.apple.swipescrolldirection -bool "false"

echo "設定を反映させるために、関連プロセスを再起動します"
killall Dock
killall Finder

echo "macOSの設定が完了しました。"
