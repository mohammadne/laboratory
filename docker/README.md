# Docker

- [container networking](https://aly.arriqaaq.com/linux-networking-bridge-iptables-and-docker/)

## installation

1. [Install using the repository](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

2. [Install via script (edge version)](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script)

    ``` zsh
    sudo su && curl -fsSL https://get.docker.com -o get-docker.sh | sh
    ```

3. [post installation](https://docs.docker.com/engine/install/linux-postinstall/)

- [permission denied issue](https://stackoverflow.com/questions/48957195/how-to-fix-docker-got-permission-denied-issue)

    ``` bash
    # add our user account to docker group into our system
    sudo usermod -aG docker $(whoami)
    newgrp docker
    sudo chmod 666 /var/run/docker.sock
    ```

## cources

- [udemy-docker-mastery](https://github.com/BretFisher/udemy-docker-mastery)
