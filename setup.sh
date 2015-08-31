#!/bin/bash

CHEFUSER=admin
CHEFPASS=ubuntu
CHEFEMAIL='ravibhure@gmail.com'
CHEFCOMPANY='COMPANY NAME'
IUSER=ubuntu
IHOME="/home/$IUSER"
DKPATH="$IHOME/chef-repo"

# Adjust the path as appropriate
cat > /tmp/solo.rb << EOF
log_level         :info
log_location      '/tmp/solo.log'
file_cache_path "/var/chef/cache"
cookbook_path "/var/chef/cookbooks"
EOF

# Recycle apt lists
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get update
# Install base deps
sudo apt-get -q -y install build-essential curl vim git
# Install chef-solo
curl -L https://www.chef.io/chef/install.sh | sudo bash
# Create required bootstrap dirs/files
sudo mkdir -p /var/chef/cache
# pull down this chef-server cookbook
cd $IHOME ;
git clone https://github.com/ravibhure/chefserver.git /var/chef/cookbooks
# GO GO GO!!!
echo "Installing chefserver"
sudo chef-solo -c /tmp/solo.rb -o 'recipe[chef-server::default]'
echo "Installing chefserver add ons - manage, reporting, push-job"
sudo chef-solo -c /tmp/solo.rb -o 'recipe[chef-server::addons]'
# Setup chef user and knife config
mkdir -p $DKPATH/.chef
sudo chef-server-ctl user-create $CHEFUSER "$CHEFCOMPANY" $CHEFEMAIL $CHEFPASS --filename $DKPATH/.chef/$CHEFUSER.pem
sudo chef-server-ctl org-create $CHEFUSER "$CHEFCOMPANY" --association_user $CHEFUSER --filename $DKPATH/.chef/$CHEFUSER-validator.pem

cat > $DKPATH/.chef/knife.rb << EOF
current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "$CHEFUSER"
client_key               "#{current_dir}/$CHEFUSER.pem"
validation_client_name   "$CHEFUSER-validator"
validation_key           "#{current_dir}/$CHEFUSER-validator.pem"
chef_server_url          "https://$(hostname -f)/organizations/$CHEFUSER"
cookbook_path            ["#{current_dir}/../cookbooks"]
EOF

cd $DKPATH;
knife ssl fetch >/dev/null ;
knife ssl check >/dev/null ;
knife client list
