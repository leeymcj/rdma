#!/bin/sh
#setup_client.sh
#create ramdisk, swapfile and run server

#Load NBDX modules
sudo modprobe xio_rdma; sudo modprobe xio_tcp; #modprobe nbdx //this is for client

#create ramdisk
sudo mkfs -q /dev/ram0 1048576
sudo mkdir /ramcache
sudo mount /dev/ram0 /ramcache
#create swap file in ramdisk
sudo dd if=/dev/zero of=/ramcache/swapfile bs=1024 count=1000000 #currently 1G of ramdisk specified in /etc/grub2.cfg

#run server
sudo raio_server -a $1 -p $2 -c ff -t rdma -f 0&       #-a <addr> -p <port> -c <cpumask> 0t <transport> -f <finite>

