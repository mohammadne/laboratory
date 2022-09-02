# Log Parser

> use logrotate utility to manage log files of a created service.

## Task

1. Setup service on Linux 

2. try to implement logrotate on the created service

## Solution

1. copy `logger.sh` shell script into `/usr/local/bin`.

    ``` bash
    sudo cp ./logger.sh /usr/local/bin
    sudo chmod +x /usr/local/bin/logger.sh
    ```

2. copy `logger.service` systemd unit in `/etc/systemd/system`.

> systemd is the init process on linux which is a collection of other tools like `systemctl`, `journalctl`, `init`, `process managment`, `networkd` (network manager), `logind` (login managment) and etc.
>
> systemd units are any entity managed by systemd like services, sockets, devices and etc.

    ``` bash
    sudo cp ./logger.service /etc/systemd/system
    ```

3. reload `systemd unit` by running:

    ``` bash
    # reload the systemctl daemon to read new file
    sudo systemctl deamon-reload

    # start the service
    sudo systemctl start logger.service 

    # verify the script is up and running as a systemd service
    sudo systemctl status logger.service 
    ```

4. use `logrotate` utility:

    > see [baeldung.com](https://www.baeldung.com/linux/rotating-logs-logrotate) and [techrepublic.com](https://www.techrepublic.com/article/manage-linux-log-files-with-logrotate/) as a good references or use the man page of `logrotate` itself.

5. copy `logger` systemd unit in `/etc/logrotate.d`.

    ``` bash
    sudo cp ./logger /etc/logrotate.d
    ```

6. reload rotation policies:

    ``` bash
    # reload the systemctl daemon to read new file
    sudo logrotate /etc/logrotate.conf --debug
    ```
