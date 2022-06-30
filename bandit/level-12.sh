bandit12@bandit:~$ mkdir /tmp/mohammad
bandit12@bandit:~$ cd /tmp/mohammad
bandit12@bandit:/tmp/mohammad$ cp ~/data.txt .

bandit12@bandit:/tmp/mohammad$ xxd -r data.txt > data1

bandit12@bandit:/tmp/mohammad$ file data1
# data1: gzip compressed data, was "data2.bin", last modified: Tue Oct 16 12:00:23 2018, max compression, from Unix

bandit12@bandit:/tmp/mohammad$ mv data1 data2.gz
bandit12@bandit:/tmp/mohammad$ gzip -d data2.gz

bandit12@bandit:/tmp/mohammad$ file data2
# data2: bzip2 compressed data, block size = 900k

bandit12@bandit:/tmp/mohammad$ mv data2 data3.bz2
bandit12@bandit:/tmp/mohammad$ bzip2 -d data3.bz2

bandit12@bandit:/tmp/mohammad$ file data3
# data3: gzip compressed data, was "data4.bin", last modified: Tue Oct 16 12:00:23 2018, max compression, from Unix

bandit12@bandit:/tmp/mohammad$ mv data3 data4.gz
bandit12@bandit:/tmp/mohammad$ gzip -d data4.gz

bandit12@bandit:/tmp/mohammad$ file data4
# data4: POSIX tar archive (GNU)

bandit12@bandit:/tmp/mohammad$ mv data4 data5.tar
bandit12@bandit:/tmp/mohammad$ tar xf data5.tar

bandit12@bandit:/tmp/mohammad$ file data5.bin
# data5.bin: POSIX tar archive (GNU)

bandit12@bandit:/tmp/mohammad$ mv data5.bin data6.tar
bandit12@bandit:/tmp/mohammad$ tar xf data6.tar

bandit12@bandit:/tmp/mohammad$ file data6.bin
# data6.bin: bzip2 compressed data, block size = 900k

bandit12@bandit:/tmp/mohammad$ mv data6.bin data7.bz2
bandit12@bandit:/tmp/mohammad$ bzip2 -d data7.bz2

bandit12@bandit:/tmp/mohammad$ file data7
# data7: POSIX tar archive (GNU)

bandit12@bandit:/tmp/mohammad$ mv data7 data8.tar
bandit12@bandit:/tmp/mohammad$ tar xf data8.tar

bandit12@bandit:/tmp/mohammad$ file data8.bin
# data8.bin: gzip compressed data, was "data9.bin", last modified: Tue Oct 16 12:00:23 2018, max compression, from Unix

bandit12@bandit:/tmp/mohammad$ mv data8.bin data9.gz
bandit12@bandit:/tmp/mohammad$ gzip -d data9.gz

bandit12@bandit:/tmp/mohammad$ file data9
# data9: ASCII text

bandit12@bandit:/tmp/mohammad$ mv data9 data10.txt
bandit12@bandit:/tmp/mohammad$ cat data10.txt
# The password is 8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL
