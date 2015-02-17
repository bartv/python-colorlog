#!/bin/bash

DIST=fedora-21-x86_64
NAME=python-colorlog

rm -rf sources srpm rpm

#rpmdev-setuptree
mkdir -p sources

spectool -C sources -g $NAME.spec
mock -r $DIST --buildsrpm --spec $NAME.spec --sources sources/*
cp -a /var/lib/mock/$DIST/result srpm

mock -r $DIST srpm/$NAME-*.src.rpm
cp -a /var/lib/mock/$DIST/result rpm
