#!/bin/bash

NAME=colorlog
VERSION=$(cat debian/changelog | grep $NAME | sed -e "s/$NAME (\([^-]*\)-.*) .*/\1/g" | head -n 1)

echo "Building version $VERSION"
TAR="${NAME}_${VERSION}.orig.tar.gz"

curl https://pypi.python.org/packages/source/c/colorlog/colorlog-$VERSION.tar.gz > $TAR

tar xvfz $TAR
cp -a debian $NAME-$VERSION

cd $NAME-$VERSION
debuild -i -uc -us

cp ../*.deb $1
