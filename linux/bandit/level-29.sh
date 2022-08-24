bandit29@bandit:~$ mkdir /tmp/mohammad

bandit29@bandit:~$ cd /tmp/mohammad

bandit29@bandit:/tmp/mohammad$ git clone ssh://bandit29-git@localhost/home/bandit29-git/repo

bandit29@bandit:/tmp/mohammad$ cd repo

bandit29@bandit:/tmp/mohammad/repo$ ls
# README.md

bandit29@bandit:/tmp/mohammad/repo$ cat README.md
# Bandit Notes
# Some notes for level29 of bandit.
## credentials
# - username: bandit30
# - password: <no passwords in production!>

bandit29@bandit:/tmp/mohammad/repo$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/dev
  remotes/origin/master
  remotes/origin/sploits-dev

bandit29@bandit:/tmp/mohammad/repo$ git checkout -b dev

bandit29@bandit:/tmp/mohammad/repo$ cat README.md
# Bandit Notes
# Some notes for level29 of bandit.
## credentials
# - username: bandit29
# - password: 5b90576bedb2cc04c86a9e924ce42faf
