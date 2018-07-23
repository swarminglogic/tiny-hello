#!/bin/bash

musl-gcc -Os --static -s -fno-stack-protector -ffunction-sections -fdata-sections \
    -Wl,--gc-sections nweb/nweb23.c -o server/nweb
strip -S --strip-unneeded --remove-section=.note.gnu.gold-version \
    --remove-section=.comment --remove-section=.note --remove-section=.note.gnu.build-id \
    --remove-section=.note.ABI-ta \
    server/nweb
sstrip server/nweb
upx server/nweb

tar -zcvf server/nweb.tar.gz -C server nweb
rm server/nweb
