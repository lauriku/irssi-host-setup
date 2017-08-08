# irssi-host-setup
This repository contains scripts and ansible playbooks to start a server up at [Scaleway](https://www.scaleway.com/) using the [scaleway-cli](https://github.com/scaleway/scaleway-cli).

It starts a VC1S server, creates an inventory for ansible to use and runs the playbooks on it.

## Requirements

* [Scaleway account (with active billing information)](https://www.scaleway.com)
* [scaleway-cli](https://github.com/scaleway/scaleway-cli)
* [ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)

## How to run

With all the tools installed and Scaleway account created, first run `scw login`

After the login is done, run `./create_server.sh`

*NOTE: This will incur costs on your Scaleway account*
