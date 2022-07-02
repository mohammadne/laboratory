# Virtual Machine

> virtual machine manager + kvm + QMUE will give you the hypervisor type 1
>
> the virtualBox gives you hypervisor type 2

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

3. change the resolution

    ``` xml
    <video>
    <model type="qxl" ram="65536" vram="65536" vgamem="16384" heads="1" primary="yes">
        <resolution x="1600" y="900"/>
    </model>
    <alias name="video0"/>
    <address type="pci" domain="0x0000" bus="0x00" slot="0x01" function="0x0"/>
    </video>
    ```
