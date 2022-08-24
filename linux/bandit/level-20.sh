tmux

# pane 1 (listener)
# pane 2 (make request to listener)

#------------------------------------------------------------- pane 1

echo GbKksEFF4yrVs6il55v6gwY5aVje5f0j | nc -l localhost -p 12345

#------------------------------------------------------------- pane 2

bandit20@bandit:~$ ./suconnect 12345
Read: GbKksEFF4yrVs6il55v6gwY5aVje5f0j
Password matches, sending next password

#------------------------------------------------------------- pane 1

# gE269g2h3mw3pwgrj0Ha9Uoqen1c9DGr
