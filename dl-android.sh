#!/bin/bash

repos()
{
# you can put the repo list blow
cat <<EOF
build
system/core
system/media

frameworks/av
frameworks/base
frameworks/native
hardware/libhardware
hardware/qcom/camera

packages/apps/Camera
packages/apps/Camera2
EOF
}

dl=`repos`
for repo in $dl
do
    if [ ! -d $repo/.git ]; then
        echo "$repo"
        git clone https://android.googlesource.com/platform/$repo $repo
    fi
done

