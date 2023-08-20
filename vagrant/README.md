# Vagrant

- <https://stackoverflow.com/questions/60907105/what-is-the-difference-between-qemu-kvm-libvirt-and-how-to-use-with-vagrant>

## Fedora (libvirt KVM)

> virtual machine manager + kvm + QMUE will give you the hypervisor type 1

1. installation

    ``` bash
    # old
    sudo dnf install gcc libvirt libvirt-devel libxml2-devel make ruby-devel -y

    # required virtualization packages
    sudo dnf -y install bridge-utils libvirt virt-install qemu-kvm

    # tools for virtual machine management
    sudo dnf install libvirt-devel virt-top libguestfs-tools guestfs-tools

    # install KVM management GUI
    sudo dnf install virt-manager -y

    sudo systemctl start libvirtd
    sudo systemctl enable libvirtd
    sudo systemctl status libvirtd
    sudo usermod -a -G libvirt $(whoami)

    sudo dnf install vagrant -y
    vagrant plugin install vagrant-libvirt
    vagrant plugin install vagrant-mutate

    vagrant up --provider=libvirt

    # in order to use synced_folder
    dnf install nfs-utils
    systemctl start nfs-server.service
    systemctl enable nfs-server.service
    ```

2. usage

    ``` bash
    # use no-parallel for a bug in multi-boxes
    vagrant up --no-parallel

    # for docker provider
    sudo vagrant up

    # destroy machine after usage
    vagrant destroy
    ```

- failure (delete vm manually)

    ``` bash
    # get the machine name
    sudo virsh list --all
    
    # destroy and undefine machine
    sudo virsh destroy <THE_MACHINE>
    sudo virsh undefine <THE_MACHINE>
    
    # get the volume name
    sudo virsh vol-list default

    # delete machine's volume
    sudo virsh vol-delete --pool default <THE_VOLUME>
    ```

- restore vagrant bridge (if you delete it)

    ``` bash
    sudo systemctl restart libvirtd
    sudo virsh net-start default
    ```

## MacOS

``` bash
brew install libiconv gcc libvirt
vagrant plugin install vagrant-libvirt
```

1. download and install [UTM](https://mac.getutm.app/).

2. check the configurations like the cpu architecture of the downloaded iso and etc, in my case I have to use Emulate option rather than the Virtulize option to get it working for downloaded ubuntu amd64(x86_64) based architecture.

3. install necessary tools on vm

    ``` bash
    sudo apt update

    # install ssh server on VM
    sudo apt install openssh-server
    sudo systemctl enable ssh
    sudo systemctl start ssh

    # copy the inet ip
    ip address show
    ```

### resources

- <https://computingforgeeks.com/using-vagrant-with-libvirt-on-linux/>

- <https://opensource.com/article/21/10/vagrant-libvirt>

### possible issues

- <https://github.com/hashicorp/vagrant/issues/12664>
- <https://github.com/vagrant-libvirt/vagrant-libvirt/issues/658>
- <https://askubuntu.com/questions/1225216/failed-to-connect-socket-to-var-run-libvirt-libvirt-sock>
