#!/bin/bash

APP=baidunetdisk
VER=$1

mkdir build
cd build
wget https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage -O appimagetool
chmod a+x ./appimagetool

mkdir $APP.AppDir
wget "https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/${VER}/baidunetdisk_${VER}_amd64.deb"
ar x ./*.deb
tar xf ./data.tar.bz2 -C $APP.AppDir

cd $APP.AppDir
cat >> ./AppRun << 'EOF'
#!/bin/sh
HERE="$(dirname "$(readlink -f "${0}")")"
exec "${HERE}"/opt/baidunetdisk/baidunetdisk --no-sandbox "$@"
EOF
chmod a+x ./AppRun
ln -s usr/share/applications/baidunetdisk.desktop baidunetdisk.desktop
ln -s usr/share/icons/hicolor/scalable/apps/baidunetdisk.svg baidunetdisk.svg
cd ../

ARCH=x86_64 ./appimagetool -n --verbose ./$APP.AppDir ../$APP-$VER-x86_64.AppImage
