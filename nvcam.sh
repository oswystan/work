#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2017 wystan
##
##       filename: camera.sh
##    description:
##        created: 2017-07-07 14:15:35
##         author: wystan
##
###########################################################################


gst-launch-1.0 nvcamerasrc fpsRange="30.0 30.0" ! 'video/x-raw(memory:NVMM), width=(int)1920, height=(int)1080, format=(string)I420, framerate=(fraction)30/1' ! nvtee ! nvvidconv flip-method=2 ! 'video/x-raw(memory:NVMM), format=(string)I420' ! nvoverlaysink -e


###########################################################################
