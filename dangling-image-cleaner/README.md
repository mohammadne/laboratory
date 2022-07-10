# Dangling Image Cleaner

> Create a cleanup script to prune dangling/unused docker containers/images by cronjob

## requirements

1. install crontab

2. install docker

3. copy `dangling-image-cleaner.sh` shell script into `/usr/local/bin`.

    ``` bash
    sudo cp ./dangling-image-cleaner.sh /usr/local/bin
    sudo chmod +x /usr/local/bin/dangling-image-cleaner.sh
    ```

4. append your `cron job` to the cron table

    ``` bash
    crontab -e
    
    # add field below to the table to run it five minutes after midnight, every day
    # 5 0 * * * /usr/local/bin/dangling-image-cleaner.sh
    ```
