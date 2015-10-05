####################### INSTALL BASIC STUFF ################

# TODO: Clone VVV, VV from Github; Create directory and add my projects; Automatically change .zshrc

#Install Brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#Update
brew update

# homebrew taps
brew tap caskroom/cask
brew tap caskroom/versions
brew tap homebrew/dupes
brew tap caskroom/versions
brew tap homebrew/boneyard
brew tap caskroom/fonts
brew tap theory/sqitch

# Updated grep
brew install grep

# Updated curl
brew install curl
brew link curl --force

# Updated bash
brew install bash

# Updated python/pip
brew install python
pip install --upgrade setuptools
pip install --upgrade pip

# Update Vim
brew install mercurial
brew install vim
export PATH=/usr/local/bin:$PATH

# homebrew binaries
binaries=(
	caskroom/cask/brew-cask
	ssh-copy-id
    heroku-toolbelt
    postgresql
    mongodb
    ghc 
    cabal-install
    sqitch_pg
	graphicsmagick
	mackup
	wget
	youtube-dl
	webkit2png
	rename
	zopfli
	ffmpeg
	python
	trash
	node
	tree
	ack
	hub
	git
	git-extras
	bradp/vv/vv
	ntfs-3g
	nmap
)

echo "installing binaries..."
brew install ${binaries[@]}

# cask apps
apps=(
	spotify
	spotifree
	utorrent
	screenflick
	sublime-text3
	vlc
	vagrant
	virtualbox
	boot2docker
	elm-platform
	android-file-transfer
	slack
	appcleaner
	firefox
	sketch
	skype
	iterm2
	sourcetree
	alfred
	google-chrome
	cyberduck
	google-hangouts
	dash
	xquartz
	the-unarchiver
	lastpass
	paparazzi
	bartender
	caffeine
	nosleep
	sketch-toolbox
	cleanmymac
	imageoptim
	macdown
	qlcolorcode 
	qlstephen 
	qlmarkdown 
	quicklook-json 
	qlprettypatch
	quicklook-csv
	betterzipql
	qlimagesize
	webpquicklook
	suspicious-package
)
# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# Vagrant plugins
vagrant plugin install vagrant-hostsupdater
vagrant plugin install vagrant-triggers

# Install fonts
fonts=(
	font-lato
	font-ubuntu
	font-roboto
	font-raleway font-raleway-dots
	font-bebas-neue
	font-meslo-lg-for-powerline
)

echo "installing fonts..."
brew cask install ${fonts[@]}

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

#Sass
sudo gem install sass

# NPM
node_packages=(
  	yo
  	gulp
  	json-server
  	nodemon
  	pm2
  	babel
  	webpack
  	xo
  	grunt
  	bower
)
echo "installing node packages..."
npm install -g  ${node_packages[@]}

###############################################################################
# Sublime Text
############################################################################### 
echo "Setting Git to use Sublime Text as default editor"
git config --global core.editor "subl -n -w"

# Oh My Zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
zsh --version
chsh -s /bin/zsh

# The Ultimate Vim Distribution
curl http://j.mp/spf13-vim3 -L -o - | sh

# verify
brew doctor

# Cleanup
brew cleanup
