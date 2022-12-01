# Vagrant

## Fedora (libvirt KVM)

> virtual machine manager + kvm + QMUE will give you the hypervisor type 1

1. installation

    ``` bash
    sudo dnf install gcc libvirt libvirt-devel libxml2-devel make ruby-devel -y
    sudo dnf install virt-manager -y # KVM management GUI

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

## MacOS

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
