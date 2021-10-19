#!/bin/sh

set -x

cd /tmp

wget -O "FoxitReader_version_Setup.run.tar.gz" "https://www.foxit.com/downloads/latest.html?product=Foxit-Reader&platform=Linux-64-bit&version=&package_type=&language=English&distID=" -q --show-progress

gzip -d 'FoxitReader_version_Setup.run.tar.gz'

OUTPUT=$(tar xvf 'FoxitReader_version_Setup.run.tar')

./${OUTPUT}
