#!/bin/bash
################################################
## this is only work on qcom 8996 soc
## dump mipi raw to /data/misc/camera directory
################################################
adb shell setprop persist.camera.raw_yuv 1
adb shell setprop persist.camera.zsl_raw 1
adb shell setprop persist.camera.dumpimg 16
adb shell setprop persist.camera.raw.format 30   # mipi raw


adb shell getprop persist.camera.raw_yuv
adb shell getprop persist.camera.zsl_raw
adb shell getprop persist.camera.dumpimg
adb shell getprop persist.camera.raw.format
