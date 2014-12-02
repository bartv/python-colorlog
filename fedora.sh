#!/bin/bash

NAME=python-colorlog

rpmdev-setuptree
spectool -R -g $NAME.spec
SRPM=$(rpmbuild -bs $NAME.spec | grep -e "^Wrote:" | tr -d " " | cut -f 2 -d :)
echo $SRPM
yum-builddep $SRPM

RPMS=$(rpmbuild --rebuild $SRPM | grep -e "^Wrote:" | tr -d " " | cut -f 2 -d :)

cp $SRPM $1
for RPM in $RPMS; do
    cp $RPM $1
done
