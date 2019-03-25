#!/bin/bash -v
tempdeb=$(mktemp /tmp/debpackage.XXXXXXXXXXXXXXXXXX) || exit 1

# For manager node
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBJRiXTpatyOCwAvb9ZRyNfquKJdpLJVkuYD4sMCAI1MiACPqQMos0e2efEu/fzCgNluIg5L5tERsweBzTtQraTRTgXhwaP1Nj5lDaSfiFBlx5KzPm9fsN9KMB3yxbX8xraMLrK/xNjgy+gqX2G0dwnY4/EUdj+npRNzf3uBY6jFaw3FD/Q1LiqA8rE9gRzKQOD8EbBF++3A+FYx/fzrL9Dx6td1K6IoWBA/O8azCYhYMf+HEmxCKA36yabGv97XmNxX8aDJPGGYePdXIZQ0lpOWZpP6zRnm2cgOHLD7A84rzXjFlA0uqVhwRjEJzvsnsnlXGl6c9MsioxZsHnQ3eD morten@morten-VirtualBox" >> /home/ubuntu/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVcBkZbQP//tgjY/lrk2HxhYiJs8c7PricTWmQDMb9T2qRAhwIw6kAUo0l8fVDZ+NLMGaHfQPY1mBnBUbiWTzNSPaNPlpQryXBon6aMGFAdypK3fjQHi9PgAtqRjqOxpwA8TYIfy6k4gqDyRerlnHmmaK69IBO2Dwjq9G92Cx9lfIQEJhogsaZUInVa090+lZuIHto/3GacOQixYVxeGDLd1X0Y+QGK72T1V2dzbZBu6hXifTVcBjsVFkT4O+6KtxIkOH0mJQBwLNuzF0hydKxNn7aDt37gzYdjz/yRD1PjRs9dN8eeRn4CorzR+PUJOjWW2xQXY/gaeDVbCdAxQed fredros@localhost.localdomain" >> /home/ubuntu/.ssh/authorized_keys

wget -O "$tempdeb" https://apt.puppetlabs.com/puppet5-release-bionic.deb
dpkg -i "$tempdeb"
apt-get update
apt-get -y install puppet-agent
echo "$(ip a | grep -Eo 'inet ([0-9]*\.){3}[0-9]*' | tr -d 'inet ' | grep 192.168.51) $(hostname).bachelor.oppgave $(hostname)" >> /etc/hosts
echo "manager_ip_address manager.bachelor.oppgave manager" >> /etc/hosts
/opt/puppetlabs/bin/puppet resource service puppet ensure=stopped enable=true
/opt/puppetlabs/bin/puppet config set server hmanager.bachelor.oppgave --section main
/opt/puppetlabs/bin/puppet config set runinterval 300 --section main
/opt/puppetlabs/bin/puppet agent -t
/opt/puppetlabs/bin/puppet agent -t  
/opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
cat <<EOF >> /etc/netplan/50-cloud-init.yaml
            nameservers:
                search: [bachelor.oppgave]
                addresses: [dns_ip_address]
EOF
netplan apply
