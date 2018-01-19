# yong
yong input method
# Build

## Build dependencies

- g++
- nodejs 
- npm 
- nodejs-legacy 
- libgtk3 
- libgtk2 
- libxkbcommon
- libibus
- qtbase5 qtbase5-private qt5-default qtcreator
- libxkbcommon
- libglib>=2.0
- p7zip-full 

## Supplement the entire missing directory structure

cd to the source code root directory

```

- mkdir -p {llib,cloud,gbk,mb,vim}/{l32,l64} 
- mkdir -p {im,config}/{l32-gtk3,l32-gtk2,l64-gtk3,l64-gtk2} 
- mkdir -p im/gtk-im/{l32-gtk3,l32-gtk2,l64-gtk3,l64-gtk2} 
- mkdir -p im/IMdkit/{l32,l64} 
- mkdir -p im/qt5-im/l64-qt5 


```

## Place build.js


download the build.js to the source code root directory

```
https://github.com/dgod/build.js

```
## Build 

build all

```

node build.js l64  
node build.js -C install copy dist

```
just build the Input method QT5 dynamic link library (libyongplatforminputcontextplugin.so)

```
node build.js -C im/qt5-im 

```

## Install

Unzip the 7z package to the directory you want to place and cd to its root directory

```

sudo ./yong-tool.sh --install64
./yong-tool.sh --select

```

TIP: please put the 'libyongplatforminputcontextplugin.so' into your QT5's platforminputcontexts,which was built in ./im/qt5-im/l64-qt5/


## uninstall 

```

sudo ./yong-tool.sh --uninstall

```
## A compilation process example

http://t.cn/RQ9XGKj
