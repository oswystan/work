#流程梳理
## options of log
```
    persist.camera.global.debug 15
    persist.camera.mct.debug    
    persist.camera.sensor.debug
    persist.camera.hal.debug
```
for others options please refer to code 
log_debug/android/camera_dbg.c for more options.

##启动流程


#驱动开发
##硬件相关
- 在同一条i2c总线上的所有设备，地址不能冲突（sensor／vcm／eeprom／flash／i2c上拉电源）；
- 在同一条i2c总线上的所有设备的电源不能和其他i2c总线上的设备共用；
