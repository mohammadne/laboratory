bandit6@bandit:/$ find / -user bandit7 -group bandit6 -size 33c 2>&1 | grep -F -v Permission | grep -F -v directory
# /var/lib/dpkg/info/bandit7.password

bandit6@bandit:/$ cat /var/lib/dpkg/info/bandit7.password
# HKBPTKQnIay4Fw76bEy8PVxKEDQRKTzs
