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
	tree
	ack
	hub
	git
	git-extras
	ntfs-3g
	nmap
)

echo "Installing node..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
nvm install node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

echo "installing binaries..."
brew install ${binaries[@]}

# cask apps
apps=(
	spotify
	spotifree
	utorrent
	screenflick
	visual-studio-code
	vlc
	android-file-transfer
	slack
	appcleaner
	firefox
	sketch
	iterm2
	sourcetree
	alfred
	google-chrome
	cyberduck
	dash
	franz
	xquartz
	the-unarchiver
	caffeine
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
	yarn
  	yo
	fixpack
	standard
	gh-pages-deploy
  	webpack
  	nodemon
  	pm2
	np
	create-react-app
	live-server
)
echo "installing node packages..."
npm install -g  ${node_packages[@]}

###############################################################################
# Sublime Text
############################################################################### 
echo "Setting Git to use Visual Code Studio as default editor"
git config --global core.editor "code -w"

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
