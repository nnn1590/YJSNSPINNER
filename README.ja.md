# YJSNSPINNER
サウンドトラック生成機能付きハンドスピナー
オリジナル: https://www.nicovideo.jp/watch/sm32015234

## 起動方法
自力で以下の環境をそろえ、`ruby`コマンドで`main.rb`を実行オナシャス！`ruby main.rb`
- Ruby
- Ruby/SDL
- [MyGame](http://dgames.jp/ja/projects/mygame/)

Debian GNU/Linuxかそれの派生(例えばUbuntu)ならこれで実行できるはずだゾ:
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

## 遊び方
SPINボタンをクリックすると野獣先輩が回転するゾ
ガバガバ抵抗演算に我慢できない兄貴たちはプログラム書き換えて、どうぞ

## キー割り当て
- ↑(上)キー:  BGMの音量を上げる
- ↓(下)キー:  BGMの音量を下げる
- Mキー     :  BGMを一時停止/再生
- Xキー     :  スピナーの回転を止める
- Rキー     :  BGM, 効果音のリロード

## BGM,効果音の追加・差し替え
BGMはBGMフォルダにぶち込めば、自動的にサウンドトラックに追加されるゾ
対応ファイル形式は `.mod`, `.s3m`, `.it`, `.xm`, `.mid`, `.mp3`, `.ogg`, `.wav` だゾ
効果音はwavフォルダにぶち込んで、どうぞ
こちらも同様に自動的に追加されるゾ(macOSでは日本語のファイル名にできない)
対応ファイル形式は `.wav` だゾ
