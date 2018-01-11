#!/bin/bash

#Partytime
#Yes, you fscked up and forgot to set the pwd again. Go fetch your backup.
rm -Rv *
#/Partytime
cp -Rv ../site.repo/sites/ff$1/* .

export GLUON_RELEASE=0.0.1.-nightly-`date +%Y-%m-%d`

mv site.mk site.mk.org
cat site.mk.org | sed "s/GLUON_RELEASE.*/GLUON_RELEASE = $GLUON_RELEASE/g" > site.mk
