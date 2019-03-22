#!/bin/bash

sudo wget https://apt.puppetlabs.com/puppet5-release-xenial.deb
echo "downloaded puppet5"
sudo dpkg -i puppet5-release-xenial.deb
echo "packaged puppet5"
sudo apt-get update
sudo apt-get install puppet-agent
echo "installed puppet-agent"
sudo -i PATH=$PATH:/opt/puppetlabs/bin/
