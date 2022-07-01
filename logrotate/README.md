# Logrotate

> use logrotate utility to manage log files.
>
> see [baeldung.com](https://www.baeldung.com/linux/rotating-logs-logrotate) and [techrepublic.com](https://www.techrepublic.com/article/manage-linux-log-files-with-logrotate/) as a good references or use the man page of `logrotate` itself.

## Task

1. Setup service on Linux 

2. try to implement logrotate on the created service

## Solution

1. copy `logger.sh` shell script into `/usr/local/bin/logger.sh`.

    ``` bash
    sudo cp ./logger.sh /usr/local/bin/
    sudo chmod +x /usr/local/bin/logger.sh
    ```

2. copy `logger.service` systemd unit in `/etc/systemd/system/logger.service`.

    ``` bash
    sudo cp ./logger.service /etc/systemd/system/
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
