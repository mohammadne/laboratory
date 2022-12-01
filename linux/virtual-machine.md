# Virtual Machine

> both `virtual machine manager` and `UTM` are run on top of it.
>
> the virtualBox gives you hypervisor type 2

## Linux

1. install `virtual machine manager`

    ``` bash
    sudo dnf install virt-manager
    ```

2. start `libvirtd`

    ``` bash
    sudo systemctl start libvirtd
    sudo systemctl enable libvirtd

    sudo systemctl status libvirtd

    sudo usermod -a -G libvirt $(whoami)
    ```

3. download an ISO and install virtual machine



5. connect to the VM via ssh

    ``` bash
    ssh <server-username>@<ip-address>
    ```

## MacOS


