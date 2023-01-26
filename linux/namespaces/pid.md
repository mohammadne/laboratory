# PID

## demo

here we try to demonstrate what will happening when we spawn up a new container from podman,docker or other CREs.

- in parent

    ``` bash
    lsns -t pid
    ```

- in child 1

    ``` bash
    unshare -p -f --mount-proc /bin/bash

    ps -ef

    sleep 2000 &
    sleep 2100 &
    sleep 2200 &

    ps -ef

    lsns -t pid
    ```

- in child 2

    ``` bash
    unshare -p -f --mount-proc /bin/bash

    ps -ef

    sleep 3000 &
    sleep 3100 &
    sleep 3200 &

    ps -ef

    lsns -t pid
    ```

- in parent

    ``` bash
    # here we have 3 namespace
    lsns -t pid

    # show all processes
    ps -e -o pidns,pid,args

    # show processes from child namespace and see their process id
    ps -e -o pidns,pid,args | grep child-ns | awk '{print $2}' | head -4

    cat /proc/child-process-id/status | grep NSpid
    ```

- in child 2 (create another sub child)

    ``` bash
    # create grand child in the child
    unshare -p -f --mount-proc sleep 4000 &

    # here we have 2 namespace
    lsns -t pid

    # show processes from child namespace and see their process id
    ps -e -o pidns,pid,args | grep child-ns | awk '{print $2}' | head -4

    cat /proc/child-process-id/status | grep NSpid
    ```

- in parent

    ``` bash
    # here we have 4 namespace
    lsns -t pid
    ```
