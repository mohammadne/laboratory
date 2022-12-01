# Languages

## Golang

``` bash
sudo dnf install golang -y
go env -w GOPATH=$HOME/.go
go env -w GOPROXY="https://goproxy.io,https://goproxy.cn,direct"
```

## Rust

``` bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# add $HOME/.cargo/bin to path
```
