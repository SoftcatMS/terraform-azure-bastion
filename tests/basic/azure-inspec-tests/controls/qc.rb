# copyright: 2018, The Authors

# Test values

resource_group1 = 'rg-bastion-test-basic'

describe azure_bastion_hosts_resource(resource_group: resource_group1, name: 'bastion-test-vm-basic') do
  it { should exist }
  its('type') { should eq 'Microsoft.Network/bastionHosts' }
  its('provisioning_state') { should include('Succeeded') }
end


describe azure_network_security_group(resource_group: 'rg-bastion-test-basic', name: 'bastion-test-vm-basic-nsg') do
  it { should exist }
  its('security_rules') { should_not be_empty }
  it { should_not allow_rdp_from_internet }
  it { should_not allow_ssh_from_internet }
end