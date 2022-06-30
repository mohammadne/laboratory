bandit28@bandit:~$ mkdir /tmp/mohammad

bandit28@bandit:~$ cd /tmp/mohammad

bandit28@bandit:/tmp/mohammad$ git clone ssh://bandit28-git@localhost/home/bandit28-git/repo

bandit28@bandit:/tmp/mohammad$ cd repo

bandit28@bandit:/tmp/mohammad/repo$ ls
# README.md

bandit28@bandit:/tmp/mohammad/repo$ cat README.md
# Bandit Notes
# Some notes for level29 of bandit.
## credentials
# - username: bandit29
# - password: xxxxxxxxxx

bandit28@bandit:/tmp/mohammad/repo$ git log
# commit 073c27c130e6ee407e12faad1dd3848a110c4f95
# Author: Morla Porla <morla@overthewire.org>
# Date:   Tue Oct 16 14:00:39 2018 +0200

#     fix info leak

# commit 186a1038cc54d1358d42d468cdc8e3cc28a93fcb
# Author: Morla Porla <morla@overthewire.org>
# Date:   Tue Oct 16 14:00:39 2018 +0200

#     add missing data

# commit b67405defc6ef44210c53345fc953e6a21338cc7
# Author: Ben Dover <noone@overthewire.org>
# Date:   Tue Oct 16 14:00:39 2018 +0200

#     initial commit of README.md

bandit28@bandit:/tmp/mohammad/repo$ git checkout 186a1038cc54d1358d42d468cdc8e3cc28a93fcb

bandit28@bandit:/tmp/mohammad/repo$ cat README.md
# Bandit Notes
# Some notes for level29 of bandit.
## credentials
# - username: bandit29
# - password: bbc96594b4e001778eee9975372716b2
