#
# Cookbook:: chef-cassandra-debian
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Equivalent to : sudo apt-get update
apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

# Equivalent to : sudo apt-get install -y default-jdk
package 'default-jdk' do
  options '-y'
end

# DPKG Installation
# cassandra
cookbook_file '/tmp/cassandra_3.11.2_all.deb' do
  # The name of the file in COOKBOOK_NAME/files/default or the path to a file located in COOKBOOK_NAME/files
  source 'cassandra_3.11.2_all.deb'

  # Identifies the steps the chef-client will take to bring the node into the desired state
  # Create a file. If a file already exists (but does not match), update that file to match.
  action :create
end

# cassandra-tools
cookbook_file '/tmp/cassandra-tools_3.11.2_all.deb' do
  source 'cassandra-tools_3.11.2_all.deb'
  action :create
end

# cassandra
# Equivalent to : sudo dpkg -i /tmp/cassandra_3.11.2_all.deb
dpkg_package 'cassandra_3.11.2_all.deb' do
  source '/tmp/cassandra_3.11.2_all.deb'
  action :install
end

# cassandra-tools
# Equivalent to : sudo dpkg -i /tmp/cassandra-tools_3.11.2_all.deb
dpkg_package 'cassandra-tools_3.11.2_all.deb' do
  source '/tmp/cassandra-tools_3.11.2_all.deb'
  action :install
end

# Equivalent to : sudo service cassandra restart
service 'cassandra' do
  supports status: true
  action [:enable, :start]
end