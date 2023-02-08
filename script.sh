#!/bin/bash
yum install -y mdadm smartmontools hdparm gdisk
disks=$(lsblk -o NAME,FSTYPE -dsn|awk '$2 == "" {print "/dev/"$1}' | head -3 | paste -sd " ")
echo $disks
errdisk=$(echo $disks | awk '{print $1}')
echo $errdisk
sudo mdadm --create /dev/md0 --level=5 --raid-devices=3 $disks
empdisk=$(lsblk -o NAME,FSTYPE -dsn|awk '$2 == "" {print "/dev/"$1}' | grep -v "/dev/md0")
echo $empdisk
sudo parted -s /dev/md0 mklabel gpt
sudo mkdir /raid5
for ((i=0; i < 5 ; i++));do y=$(($i*20));sudo parted /dev/md0 mkpart primary ext4 $y% $(($y+20))%;x=$(($i+1));sudo mkdir -p /raid5/p$x;sudo mkfs.ext4 /dev/md0p$x;sudo mount /dev/md0p$x /raid5/p$x;grep -q "init-raid-$x" /etc/fstab || printf "#init-raid-$x\n/dev/md0p$x\t/raid5/p$x\text4\tdefaults\t0\t2\n" | sudo tee -a /etc/fstab;done
sudo mkdir /etc/mdadm
sudo chown vagrant: /etc/mdadm/
sudo echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
sudo mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf
sudo mdadm --detail /dev/md0
while [ "${state,,}" = "degraded" ]
  state=$(sudo mdadm --detail /dev/md0 | grep -oE "degraded")
do
  sleep 1
done
sudo mdadm --detail /dev/md0
sudo mdadm --manage /dev/md0 --fail $errdisk
sudo mdadm --detail /dev/md0
sudo mdadm --manage /dev/md0 --remove $errdisk
sudo mdadm --detail /dev/md0
sudo mdadm --manage /dev/md0 --add $empdisk
sudo mdadm --detail /dev/md0
while [ "${state,,}" = "degraded" ]
  state=$(sudo mdadm --detail /dev/md0 | grep -oE "degraded")
do
  sleep 1
done
sudo mdadm --detail /dev/md0
sudo mdadm --manage /dev/md0 --fail $empdisk
sudo mdadm --detail /dev/md0
sudo mdadm --manage /dev/md0 --remove $empdisk
sudo mdadm --detail /dev/md0
sudo mdadm --manage /dev/md0 --add $errdisk
sudo mdadm --detail /dev/md0
while [ "${state,,}" = "degraded" ]
  state=$(sudo mdadm --detail /dev/md0 | grep -oE "degraded")
do
  sleep 1
done
sudo mdadm --detail /dev/md0