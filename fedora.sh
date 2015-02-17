#!/bin/bash

NAME=$(basename $(pwd))
DIST=fedora-21-x86_64

if [[ $# -eq 1 ]]; then
    DIST=$1
fi

rm -rf sources srpm rpm

#rpmdev-setuptree
mkdir -p sources || exit 1

/usr/bin/spectool -C sources -g $NAME.spec || exit 1
/usr/bin/mock -r $DIST --buildsrpm --spec $NAME.spec --sources sources/* || exit 1
cp -a /var/lib/mock/$DIST/result srpm || exit 1

/usr/bin/mock -r $DIST srpm/$NAME-*.src.rpm || exit 1
cp -a /var/lib/mock/$DIST/result rpm || exit 1
