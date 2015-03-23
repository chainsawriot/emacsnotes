* ln is TARGET then LINK name
* copy a directory by: cp -avr
* user management
  * adduser: It is better to use adduser than useradd
  * add a specific user to a group: usermod -g <groupname> <username>
* create software raid on Debian
1. Install new drives
2. create for the existance of new drives using: #fdisk -l
3. Using parted to create new partitions on new drives: #parted /dev/sdc
4. Remember to set GPT to support >2.2TB drive: mklabel gpt
5. Make parition: mkpart primary 0.0TB 3.0TB
6. quit
7. No need to create FS for this point
8. mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc2
9. Check for the syncing procedure: cat /proc/mdstat
10. mkfs.ext4 /dev/md0

Add back missed device to the software raid

1. #mdadm --manage /dev/md0 -a /dev/sdc1

* Knoppix notes
1. ssh and cron is not started by default, need to add it in /etc/rc.local
2. PYTHONPATH is difficult to set. Maybe better to set it by append the path to sys.path in the python script
