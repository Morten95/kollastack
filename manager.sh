#!/bin/bash

sudo wget https://apt.puppetlabs.com/puppet5-release-xenial.deb
echo "downloaded puppet5"
sudo dpkg -i puppetlabs-release-xenial.deb
echo "packaged puppet"
sudo apt-get update
sudo apt-get install puppetserver
echo "installed puppetserver"
sudo PATH=$PATH:/opt/puppetlabs/bin/
#VIRKER IKKE WTF
