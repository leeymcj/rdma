#setup_server.sh
#create ramdisk, swapfile and run server

#Load NBDX modules
sudo modprobe xio_rdma; sudo modprobe xio_tcp; sudo modprobe nbdx #//this is for client

#first create host then device in the host
sudo nbdxadm -o create_host -i 0 -p $1:$2 #-i <host_id> -p <ip>:<port>
sudo nbdxadm -o create_device -i 0 -d 0 -f "/ramcache/swapfile"

#check /dev/nbdx0 created
ls /dev/nbdx0

#setup linux swap area and activate
sudo mkswap /dev/nbdx0
sudo swapon -p 60 /dev/nbdx0 #with priority 60

#check swap space
sudo swapon -s

