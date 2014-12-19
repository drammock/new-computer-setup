#! /bin/bash -e
## Extra system setup commands, to complement the LABSN setup scripts.

## ## ## ##
## SETUP ##
## ## ## ##
## Location of custom builds directory (should already exist).
build_dir="$HOME/Builds"
mkdir -p $build_dir
## Change these URLs to the correct (latest) versions before running
praat_targz_url="http://www.fon.hum.uva.nl/praat/praat5402_linux64.tar.gz"
sublime_deb_url="http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3065_amd64.deb"
brackets_deb_url="https://github.com/adobe/brackets/releases/download/release-1.0/Brackets.Release.1.0.64-bit.deb"
zotero_tarbz_url="https://download.zotero.org/standalone/4.0.23/Zotero-4.0.23_linux-x86_64.tar.bz2"
zotero_xpi_url="https://download.zotero.org/extension/zotero-4.0.24.1.xpi"
chrome_deb_url="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
nodejs_targz_url="http://nodejs.org/dist/v0.10.34/node-v0.10.34-linux-x64.tar.gz"
archon_zip_url="https://bitbucket.org/vladikoff/archon/get/v1.2-x86_64.zip"
## Detect current location of this script, so it can find the other
## resources packaged with it (.desktop files, etc)
this_script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

## ## ## ## ## ## ##
## SYSTEM TUNING  ##
## ## ## ## ## ## ##
sudo echo "# Decrease swap usage to a reasonable level" >> /etc/sysctl.conf
sudo echo "vm.swappiness=10" >> /etc/sysctl.conf
sudo echo "# Improve cache management" >> /etc/sysctl.conf
sudo echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf
#echo -e 'APT::Install-Recommends "0";' | sudo tee /etc/apt/apt.conf
#echo -e 'APT::Install-Suggests "0";' | sudo tee /etc/apt/apt.conf

## ## ## ## ## ## ## ##
## ASSORTED SOFTWARE ##
## ## ## ## ## ## ## ##
## FILE SYSTEM UTILITIES
sudo apt-get install baobab gparted
## ENCRYPTION
sudo apt-get install gnupg seahorse enigmail
## DATABASE TOOLS
sudo apt-get install sqlite3 mysql-server mysql-client mysql-workbench
## MISC. APPS
sudo apt-get install virtualbox filezilla chromium-browser thunderbird
## CAIRO-DOCK: a nice dock
sudo apt-get install --no-install-recommends cairo-dock
## COMPIZ: compositing manager / all-around UI tweak toolkit
sudo apt-get install wmctrl compiz compiz-plugins compiz-fusion \
compiz-fusion-plugins-extra ccsm 
## XPLANETFX: renderings of planet earth for the desktop background
cd
wget "http://repository.mein-neues-blog.de:9000/PublicKey"
sudo apt-key add PublicKey
rm PublicKey
echo "deb http://repository.mein-neues-blog.de:9000/ /" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install xplanetfx

## ## ## ## ## ## ## ## ## ##
## SUPPORT FOR RUNNING APK ##
## ## ## ## ## ## ## ## ## ##
## GOOGLE CHROME
cd
wget "$chrome_deb_url"
chrome_deb="${chrome_deb_url##*/}"
sudo dpkg -i "$chrome_deb"
rm "$chrome_deb"
## install NodeJS
#cd
#wget "$nodejs_targz_url"
#nodejs_targz="${nodejs_targz_url##*/}"
#tar -zxf "$nodejs_targz"
#rm "$nodejs_targz"
sudo apt-get install npm nodejs nodejs-legacy lib32stdc++6
## install chromeos-apk
sudo npm install chromeos-apk -g
## ARCHON (alternative android runtime for Chrome)
cd
mkdir Home
wget "$archon_zip_url"
archon_zip="${archon_zip_url##*/}"
unzip "$archon_zip" -d $HOME/Home
rm "$archon_zip"
## run APKs with:
#chromeos-apk ThePackageName.apk --archon

## ## ## ## ## ## ##
##  TEXT EDITORS  ##
## ## ## ## ## ## ##
## SCRIBES: an auto-saving editor with configurable snippets
sudo apt-get install scribes
## SUBLIME: easiest way to get Praat syntax highlighting without KDE
cd
wget "$sublime_deb_url"
sublime_deb="${sublime_deb_url##*/}"
sudo dpkg -i "$sublime_deb"
rm "$sublime_deb"
## ATOM: GitHub's in-house editor, TBD how great this one will be
cd
wget "https://atom.io/download/deb"
sudo dpkg -i atom-amd64.deb
rm atom-amd64.deb
## BRACKETS: Adobe's web-dev editor; great for HTML, CSS, JavaScript
cd
wget "$brackets_deb_url"
brackets_deb="${brackets_deb_url##*/}"
sudo dpkg -i "$brackets_deb"
rm "$brackets_deb"

## ## ## ## ## ## ## ## ## 
##  AUDIO APPLICATIONS  ##
## ## ## ## ## ## ## ## ##
## SOX
sudo apt-get install sox
## CLEMENTINE: basically an iTunes clone
sudo add-apt-repository ppa:me-davidsansome/clementine
sudo apt-get update
sudo apt-get install clementine
## PRAAT
cd
wget "$praat_targz_url"
praat_targz=${praat_targz_url##*/}
tar -zxf "$praat_targz"
sudo mv praat /usr/bin/praat
rm "$praat_targz"
# desktop integration:
cd "$this_script_dir"
tar -zxf "praat_desktop_integration.tar.gz"
cd praat_desktop_integration
# install praat desktop file to get it in the menus
cat praat-desktop.txt > praat.desktop
xdg-desktop-menu install --novendor praat.desktop
rm praat.desktop
# add the new mime type to the database
xdg-icon-resource install --novendor --context apps --size 16 praat16.png praat
xdg-icon-resource install --novendor --context apps --size 22 praat22.png praat
xdg-icon-resource install --novendor --context apps --size 32 praat32.png praat
xdg-icon-resource install --novendor --context apps --size 48 praat48.png praat
xdg-icon-resource install --novendor --context apps --size 64 praat64.png praat
xdg-icon-resource install --novendor --context apps --size 128 praat128.png praat
xdg-icon-resource install --novendor --context mimetypes --size 16 praat-script16.png x-praat
xdg-icon-resource install --novendor --context mimetypes --size 22 praat-script22.png x-praat
xdg-icon-resource install --novendor --context mimetypes --size 32 praat-script32.png x-praat
xdg-icon-resource install --novendor --context mimetypes --size 48 praat-script48.png x-praat
xdg-icon-resource install --novendor --context mimetypes --size 64 praat-script64.png x-praat
xdg-icon-resource install --novendor --context mimetypes --size 128 praat-script128.png x-praat
xdg-mime install praat-mime.xml
# assign all praat scripts to open with Sublime text editor by default
xdg-mime default sublime_text.desktop text/x-praat
# clean up
cd "$this_script_dir"
rm -R praat_desktop_integration/

## ## ## ## ## ## ## ## ## ##
##  FONTS AND TYPESETTING  ##
## ## ## ## ## ## ## ## ## ##
## see also http://tex.stackexchange.com/a/95373 for "vanilla" TeX Live
sudo apt-get install --no-install-recommends texlive
## SIL fonts and software
cd
wget "http://packages.sil.org/sil.gpg"
sudo apt-key add sil.gpg
rm sil.gpg
codename=$(lsb_release -c -s)
echo "deb http://packages.sil.org/ubuntu $codename main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install  libkmfl0 libkmflcomp0 ibus-kmfl kmfl-keyboard-ipa \
fonts-sil-charissil fonts-sil-doulossil 
## other fonts
sudo apt-get install ttf-mplus otf-stix ttf-droid ttf-dejavu-core \
ttf-dejavu-extra ttf-freefont ttf-liberation ttf-ubuntu-font-family \
ttf-linux-libertine 

## ## ## ## ##
##  PANDOC  ##
## ## ## ## ##
sudo apt-get install haskell-platform
cabal update
cabal install pandoc pandoc-citeproc

## ## ## ## ##
##  JEKYLL  ##
## ## ## ## ##
sudo apt-get install ruby ruby-dev
gem install jekyll jekyll-scholar 
gem install faraday faraday_middleware  # jekyll orcid dependencies
cd $build_dir
git clone git@github.com:mfenner/jekyll-orcid.git

## ## ## ## ##
##  ZOTERO  ##
## ## ## ## ##
zotero_tarbz=${zotero_tarbz_url##*/}
zotero_tar=$(basename($zotero_tarbz, .bz2))
cd /opt
wget "$zotero_tarbz_url"
bunzip2 "$zotero_tarbz"
tar -xf "$zotero_tar"
rm "$zotero_tar"
# install desktop file to get it in the menus
cd "$this_script_dir"
cat zotero-desktop.txt > zotero.desktop
xdg-desktop-menu install --novendor zotero.desktop
# sudo mv zotero.desktop /usr/share/applications
rm zotero.desktop

## TODO ##
## htk3.4 
## p2fa
## CMU dict
## mime type for markdown (scribes doesn't highlight .md)

## ## ## ## ## ## ##
## MOZILLA ADDONS ##
## ## ## ## ## ## ##
	## FIREFOX about:config CHANGES:
	## browser.backspace-action = 0  # backspace goes back in history
	## plugin.default.state = 2      # automatically allow plugins
	## THUNDERBIRD:
	## enigmail, flat folder tree, google contacts, keyconfig,
	## quicktext, thunderbird conversations, "tt deep dark" theme	

## ## ## ## ## ## ##
##  CONFIG FILES  ##
## ## ## ## ## ## ##
	## TODO ##
	## These need to be manually moved from old machine
	## CCSM, cairo-dock

