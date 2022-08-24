bandit16@bandit:~$ nmap localhost -p 31000-32000

# Starting Nmap 7.40 ( https://nmap.org ) at 2022-06-30 10:33 CEST
# Nmap scan report for localhost (127.0.0.1)
# Host is up (0.00043s latency).
# Not shown: 996 closed ports
# PORT      STATE    SERVICE
# 31046/tcp open     unknown
# 31518/tcp filtered unknown
# 31691/tcp open     unknown
# 31790/tcp open     unknown
# 31960/tcp open     unknown

bandit16@bandit:~$ echo "cluFn7wTiGryunymYOu4RcffSxQluehd" | openssl s_client -connect localhost:31790 -ign_eof
# Correct!
# -----BEGIN RSA PRIVATE KEY-----
# ...
# -----END RSA PRIVATE KEY-----

bandit16@bandit:~$ mkdir /tmp/mohammad
bandit16@bandit:~$ cd /tmp/mohammad

# copy/paste the private SSH key therein
bandit16@bandit:~$ nano /tmp/mohammad/sshkey.txt

bandit16@bandit:~$ chmod 600 /tmp/mohammad/sshkey.txt

bandit16@bandit:~$ ssh bandit17@localhost -i /tmp/mohammad/sshkey.txt

bandit17@bandit:~$ cat /etc/bandit_pass/bandit17
# xLYVMN9WE5zQ5vHacb0sZEVqbrp7nBTn
