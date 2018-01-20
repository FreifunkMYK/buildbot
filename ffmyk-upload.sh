#!/bin/bash

pushd output/
rm md5sums.txt sha1sums.txt md5sums.txt.gpg sha1sums.txt.gpg sha256sums.txt sha256sums.txt.gpg
echo Generiere Pruefsummen
echo MD5...
md5deep -r ./ > md5sums.txt
echo SHA1...
sha1deep -r ./ > sha1sums.txt
echo SHA256...
sha256deep -r ./ > sha256sums.txt
echo Signiere Pruefsummen...
gpg --output md5sums.txt.gpg --armor --detach-sig md5sums.txt
gpg --output sha1sums.txt.gpg --armor --detach-sig sha1sums.txt
gpg --output sha256sums.txt.gpg --armor --detach-sig sha256sums.txt
echo Erledigt - Upload startet...

touch sync
chmod 774 sync

#Mind the keys...
rsync -avzPe 'ssh ' --delete ./ buildbot@****:/srv/http/ff$1/nightly/$2/
ssh buildbot@**** 'date > /tmp/ffmyk-sync-NORMAL ; chmod 777 /tmp/ffmyk-sync-NORMAL'

popd

echo EOT
