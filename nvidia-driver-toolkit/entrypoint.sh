#!/bin/bash

set -e

if [ -f /tmp/ready ]
then
  rm /tmp/ready
fi

if [ -n "${DRIVER_LOCATION}" ]
then
    echo "Installing nvidia driver from ${DRIVER_LOCATION}"
    curl -o /tmp/NVIDIA.run -k $DRIVER_LOCATION
    chmod +x /tmp/NVIDIA.run
    /tmp/NVIDIA.run -q --ui=none --no-systemd
else
    echo "No DRIVER_LOCATION specified. skipping..."
fi

echo "running nvidia vgpud"
/usr/bin/nvidia-vgpud
/usr/bin/nvidia-vgpu-mgr

echo "driver ready" > /tmp/ready

tail -f /dev/null
