# Amirkabir network issue

This issue is because of conflict in private range IPs.

1. get default gateway

    > for example in my case it was 172.24.32.1

    ```bash
    ip route
    ```

2. check your dns server

    > for example in my case it was 172.16.1.2 and 172.16.1.3

    ```bash
    cat /etc/resolv.conf
    ```

3. pass your nameserver requests via the default gateway

    ```bash
    ip route add 172.16.1.2/32 via 172.24.32.1
    ip route add 172.16.1.3/32 via  172.24.32.1
    ```
