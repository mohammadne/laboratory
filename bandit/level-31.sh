bandit31@bandit:~$ mkdir /tmp/mohammad

bandit31@bandit:~$ cd /tmp/mohammad

bandit31@bandit:/tmp/mohammad$ git clone ssh://bandit31-git@localhost/home/bandit31-git/repo

bandit31@bandit:/tmp/mohammad$ cd repo

bandit31@bandit:/tmp/mohammad/repo$ ls
# README.md

bandit31@bandit:/tmp/mohammad/repo$ cat README.md
# This time your task is to push a file to the remote repository.
# Details:
#     File name: key.txt
#     Content: 'May I come in?'
#     Branch: master

bandit31@bandit:/tmp/mohammad/repo$ echo "May I come in?" > key.txt

bandit31@bandit:/tmp/mohammad/repo$ git add  key.txt -f

bandit31@bandit:/tmp/mohammad/repo$ git commit

bandit31@bandit:/tmp/mohammad/repo$ git push origin
# ...
# remote: Well done! Here is the password for the next level:
# remote: 56a9bf19c63d650ce78e6ec0354ee45e
# ...

