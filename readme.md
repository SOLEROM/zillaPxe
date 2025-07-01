# About
ref: based on https://github.com/ferrarimarco/docker-pxe  //see ferr_readme.md

## build 

* prepare clonezilla zip

```
wget https://yer.dl.sourceforge.net/project/clonezilla/clonezilla_live_stable/3.2.2-15/clonezilla-live-3.2.2-15-amd64.zip?viasf=1

unzip -j clonezilla-live-3.2.2-15-amd64.zip live/vmlinuz live/initrd.img live/filesystem.squashfs -d ./tftpboot/

```

```
make build DOCKERFILE=Dockerfile_Pxe_Clonzilla
make run
```

## run server

```
sudo dnsmasq --no-daemon --dhcp-range=15.0.0.2,proxy
sudo dnsmasq --no-daemon --interface=enx482ae38e0650 --bind-interfaces --dhcp-range=15.0.0.2,proxy
```



## test

```
sudo apt install -y wget gnupg2
wget https://releases.hashicorp.com/vagrant/2.4.1/vagrant_2.4.1-1_amd64.deb
sudo apt install ./vagrant_2.4.1-1_amd64.deb

> vagrant up
```
