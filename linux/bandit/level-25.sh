bandit25@bandit:~$ grep bandit26 /etc/passwd
# bandit26:x:11026:11026:bandit level 26:/home/bandit26:/usr/bin/showtext

bandit25@bandit:~$ cat /usr/bin/showtext
# export TERM=linux
# more ~/text.txt
# exit 0

# reduce the height of the terminal

bandit25@bandit:~$ ssh bandit26@localhost -i bandit26.sshkey

# Enable vi editor by pressing 'v' at the more window.
# Now leverage the functionality of the vi editor to invoke a custom shell.
# Now execute sh command at vi terminal to spawn a shell.
# We are successfully login as the bandit26 user.
