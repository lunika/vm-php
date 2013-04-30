README
======

Create a virtual machine using vagrant.

Provisionning is made with puppet

This VM provide a LAMP server with php 5.4

mysql root password : root

Installation
------------

This VM use NFS share so check if you operating system have nsfd installed : http://docs-v1.vagrantup.com/v1/docs/nfs.html

Install Vagrant and virtualbox : http://docs-v1.vagrantup.com/v1/docs/getting-started/index.html

download vagrant ssh key :

``` bash
$ wget https://raw.github.com/mitchellh/vagrant/master/keys/vagrant -O ~/.ssh/insecure_private_key
$ chmod 600 ~/.ssh/insecure_private_key
```

then :

``` bash
$ git clone --recursive https://github.com/lunika/vm-php.git
$ cd vm-php
$ vagrant up
```
