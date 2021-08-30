#!/bin/bash

echo 1 > /sys/bus/pci/devices/0000:00:02.0/0df4db72-fb56-4500-b422-798f503a6a98/remove
sleep 2
rmmod kvmgt
systemctl stop gdm
sleep 2
#sh -c "echo 1 > /sys/class/drm/card0/device/reset"
echo 1 > /sys/kernel/debug/dri/0/i915_wedged
sleep 2
sh -c "echo -n 0000:00:02.0 > /sys/bus/pci/drivers/i915/unbind"
sleep 30
rmmod i915
sleep 10
modprobe i915
sleep 2
systemctl start gdm
sleep 2
modprobe kvmgt
sleep 2
#sudo systemctl start setup-gvt.service
sh -c "echo 0df4db72-fb56-4500-b422-798f503a6a98 > /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_4/create"
sleep 4
#echo "Script executed from: ${PWD}"
#./vm_syzkaller.sh
#done
