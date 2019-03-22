#!bin/bash

sudo wget https://apt.puppetlabs.com/puppet6-release-xenial.deb
sudo dpkg -i puppetlabs-release-xenial.deb
sudo apt-get update
sudo apt-get install puppetserver
sudo PATH=$PATH:/opt/puppetlabs/bin/
#VIRKER IKKE WTF
