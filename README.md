# YJSNSPINNER
Hand spinner with soundtrack generator
Original from: https://www.nicovideo.jp/watch/sm32015234
日本語`README.md`はこ↑こ↓: https://github.com/nnn1590/YJSNSPINNER/blob/master/README.ja.md

## How to launch
Setup/install these, and run `main.rb` with `ruby` command!`ruby main.rb`
- Ruby
- Ruby/SDL
- [MyGame](http://dgames.jp/ja/projects/mygame/)

If you're using Debian GNU/Linux or its derivatives(e.g. Ubuntu), run these command to play:
```bash
sudo apt install ruby{,-sdl} git svn
svn checkout http://svn.sourceforge.jp/svnroot/mygame/trunk mygame
git clone https://github.com/nnn1590/YJSNSPINNER.git
cd mygame
sed -i -e 's/Config/Rb&/g' install_mygame.rb lib/mygame.rb
sudo ruby install install_mygame.rb
cd ../YJSNSPINNER
ruby main.rb
```

## How to play
If you click the SPIN button, the YJSNPI(beast senior) will rotate.
If you can't stand the baggy resistance operation, please rewrite the program.

## Controls
- Up key  :  Turn up the volume of the BGM
- Down key:  Turn down the volume of the BGM
- M key   :  Pause or play the BGM
- X key   :  Stop spinning the spinner
- R key   :  Reload the BGM and SE

## Adding and/or replacing BGM and SE
BGM will be automatically added to the soundtrack if you put it in the `BGM` folder.
Supported file formats are `.mod`, `.s3m`, `.it`, `.xm`, `.mid`, `.mp3`, `.ogg` and `.wav`.
You can put the SE in the wav folder.
This is also added automatically as well (it can't be a Japanese file name in macOS).
The supported file format is `.wav`.
