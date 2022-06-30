bandit22@bandit:~$ ls /etc/cron.d
# atop  cronjob_bandit22  cronjob_bandit23  cronjob_bandit24

bandit22@bandit:~$ cat /etc/cron.d/cronjob_bandit23
# @reboot bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null
# * * * * * bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null

bandit22@bandit:~$ cat /usr/bin/cronjob_bandit23.sh
# myname=$(whoami)
# mytarget=$(echo I am user $myname | md5sum | cut -d ' ' -f 1)
# echo "Copying passwordfile /etc/bandit_pass/$myname to /tmp/$mytarget"
# cat /etc/bandit_pass/$myname > /tmp/$mytarget

echo I am user bandit23 | md5sum | cut -d ' ' -f 1
# 8ca319486bfbbc3663ea0fbe81326349

bandit22@bandit:/usr/bin$ cat /tmp/8ca319486bfbbc3663ea0fbe81326349
# jc1udXuA1tiHqjIsL8yaapX5XIAI6i0n
