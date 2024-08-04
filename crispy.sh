#!/usr/bin/env bash

# packages
sudo apt-get build-dep -y crispy-doom

# repo & soundfont
git clone --depth=1 https://github.com/fabiangreffrath/crispy-doom ~/crispy-doom
wget https://github.com/trevor0402/SC55Soundfont/releases/download/v1.2b/SC-55.SoundFont.v1.2b.sf2 -P ~/Music

# build
cd ~/crispy-doom
bear -- autoreconf -fiv
bear -- ./configure
bear -- make
cd -

# dir & links
ln -s ~/crispy-doom/src/{crispy-doom,crispy-setup} ~/.local/bin/
mkdir -p ~/.local/share/games/doom
cp -r .local ~

# replace USERNAME in home path
read -s -p 'linux username? ' username
sed -i "s/USERNAME/$username/g" ~/.local/share/crispy-doom/crispy-doom.cfg

# doom 1
wget "https://archive.org/download/2020_03_22_DOOM/DOOM%20WADs/Ultimate%20Doom%2C%20The.zip"
unzip "Ultimate Doom, The.zip"
mv DOOM.WAD ~/.local/share/games/doom/
rm "Ultimate Doom, The.zip"

# doom 2
wget "https://archive.org/download/2020_03_22_DOOM/DOOM%20WADs/Doom%20II%20-%20Hell%20on%20Earth%20%28v1.9%29.zip"
unzip "Doom II - Hell on Earth (v1.9).zip"
mv DOOM2.WAD ~/.local/share/games/doom/
rm "Doom II - Hell on Earth (v1.9).zip"

# sigil
wget "https://romero.com/s/SIGIL_v1_21.zip"
unzip SIGIL_v1_21.zip
mv SIGIL_v1_21/SIGIL_v1_21.wad ~/.local/share/games/doom
rm SIGIL_v1_21.zip
rm -rf __MACOSX/
rm -rf SIGIL_v1_21

# sigil 2
wget "https://romero.com/s/SIGIL_II_V1_0.zip"
unzip SIGIL_II_V1_0.zip
mv SIGIL_II_V1_0.WAD ~/.local/share/games/doom
rm SIGIL_II_*
