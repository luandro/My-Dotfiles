####################### INSTALL BASIC STUFF ################

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#Update
brew update
brew upgrade --all

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
brew tap homebrew/versions
brew install bash-completion2
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/bash
brew install wget --with-iri

# Updated python/pip
brew install python
pip install --upgrade setuptools
pip install --upgrade pip

# Update Vim
brew install mercurial
brew install vim
export PATH=/usr/local/bin:$PATH

echo "Installing node..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
nvm install node

#install YARN
npm i -g yarn

# Install packages
node_packages=(
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
	truffle
	ethereumjs-testrpc
)
echo "installing node packages..."
yarn global add  ${node_packages[@]}

# homebrew binaries
binaries=(
	caskroom/cask/brew-cask
	ssh-copy-id
    heroku-toolbelt
    postgresql
    mongodb
	graphicsmagick
	mackup
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
	appcleaner
	firefox
	sketch
	iterm2
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
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
brew install moreutils
brew install gnu-sed --with-default-names


# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

#Sass
sudo gem install sass

###############################################################################
# Visual Code Studio
############################################################################### 
echo "Setting Git to use Visual Code Studio as default editor"
git config --global core.editor "code -w"

# Oh My Zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
zsh --version
chsh -s /bin/zsh

# Remove plugins
grep -v "plugins=(git)" ~/.zshrc > ~/.zshrc2; mv ~/.zshrc2 ~/.zshrc
grep -v 'ZSH_THEME="robbyrussell"' ~/.zshrc > ~/.zshrc2; mv ~/.zshrc2 ~/.zshrc

addToZshrc=(
	ZSH_THEME="agnoster"
	plugins=(git autojump brew node npm sudo lighthouse web-search osx)
	export NVM_DIR=~/.nvm
	source ~/.nvm/nvm.sh 
	export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"
	export SSH_KEY_PATH="~/.ssh/rsa_id"
	export EDITOR='mvim'
	alias zshconfig="vim ~/.zshrc"
	alias ohmyzsh="vim  ~/.oh-my-zsh"
	alias v="mvim -v"
	export PATH="/usr/local/sbin:$PATH"

)

echo ${addToZshrc[@]} >> ~/.zshrc

# Z
wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O ~/z.sh
echo . ~/z.sh >> ~/.zshrc


# The Ultimate Vim Distribution
curl http://j.mp/spf13-vim3 -L -o - | sh

# Git & SSH
git credential-osxkeychain
git config --global credential.helper osxkeychain
ssh-keygen -t rsa -b 4096 -C "luandro@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
chromium-browser https://github.com/settings/keys

# verify
brew doctor

# Cleanup
brew cleanup
