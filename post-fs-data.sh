#!/system/bin/sh
# Created by Hadi Khoirudin, S.Kom.
#

if [ ! -e /mnt/expand/$(ls /mnt/expand) ]
then
exit
fi;
wait_boot_complete()
{
until [ "x\$(getprop sys.boot_completed)" == "x1" ] 
do
count=0
while ! mountpoint -q "/storage/emulated/0"
do
    count=`expr $count + 1`
    if mountpoint -q /mnt/runtime/default/emulated
    then
        break
    elif mountpoint -q /storage/emulated
    then
        break
    elif test $count -ge 1200
    then
        break
    else
        sleep 0.1
    fi
done
sleep 0.5
if ! mountpoint -q "/data/media"
then

    mount -o bind /mnt/expand/$(ls /mnt/expand)/media /data/media
    
   chmod -R 777 /mnt/expand/$(ls /mnt/expand)/media
	chmod -R 777 /mnt/expand/$(ls /mnt/expand)/media/0
	chmod -R 777 /mnt/expand/$(ls /mnt/expand)/media/obb
	
	chown -R root:media_rw /mnt/expand/$(ls /mnt/expand)/media
	chown -R root:media_rw /mnt/expand/$(ls /mnt/expand)/media/0
	chown -R root:media_rw /mnt/expand/$(ls /mnt/expand)/media/obb
	
	df >/data/adopted
	
fi

done
} 

wait_boot_complete
