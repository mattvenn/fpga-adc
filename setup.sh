SLOTS=/sys/devices/bone_capemgr.9/slots
echo logibone > $SLOTS
logi_loader ./2adcRead-2Mhz-pcb.bit 
