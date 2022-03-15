# terraform-azure-bastion
Deploys bastion host with a public IP into a subnet and configures the default ports required for Bastion. A subnet and vNet will already need to be deployed and available for the bastion to be deployed into.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_bastion_host.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |
| [azurerm_network_security_group.bastion_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_subnet_network_security_group_association.bastion_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_resource_group.bastion](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_name"></a> [bastion\_name](#input\_bastion\_name) | Bastion resource name | `string` | n/a | yes |
| <a name="input_bastion_nsg_name"></a> [bastion\_nsg\_name](#input\_bastion\_nsg\_name) | Bastion Public IP resource name | `string` | n/a | yes |
| <a name="input_bastion_nsg_rules"></a> [bastion\_nsg\_rules](#input\_bastion\_nsg\_rules) | NSG rules used for Azure Bastion Host | `list(map(string))` | <pre>[<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_port_ranges": "443",<br>    "direction": "Inbound",<br>    "name": "AllowHttpsInBound",<br>    "priority": "100",<br>    "protocol": "Tcp",<br>    "source_address_prefix": "Internet",<br>    "source_port_ranges": "*"<br>  },<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_port_ranges": "443,4443",<br>    "direction": "Inbound",<br>    "name": "AllowGatewayManagerInBound",<br>    "priority": "110",<br>    "protocol": "Tcp",<br>    "source_address_prefix": "GatewayManager",<br>    "source_port_ranges": "*"<br>  },<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "*",<br>    "destination_port_ranges": "443",<br>    "direction": "Inbound",<br>    "name": "AllowLoadBalancerInBound",<br>    "priority": "120",<br>    "protocol": "Tcp",<br>    "source_address_prefix": "AzureLoadBalancer",<br>    "source_port_ranges": "*"<br>  },<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "VirtualNetwork",<br>    "destination_port_ranges": "8080,5701",<br>    "direction": "Inbound",<br>    "name": "AllowBastionHostCommunicationInBound",<br>    "priority": "130",<br>    "protocol": "*",<br>    "source_address_prefix": "VirtualNetwork",<br>    "source_port_ranges": "*"<br>  },<br>  {<br>    "access": "Deny",<br>    "destination_address_prefix": "*",<br>    "destination_port_ranges": "*",<br>    "direction": "Inbound",<br>    "name": 
"DenyAllInBound",<br>    "priority": "1000",<br>    "protocol": "*",<br>    "source_address_prefix": "*",<br>    "source_port_ranges": "*"<br>  },<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "VirtualNetwork",<br>    "destination_port_ranges": "22,3389",<br>    "direction": "Outbound",<br>    "name": "AllowSshRdpOutBound",<br>    "priority": "100",<br>    "protocol": "Tcp",<br>    "source_address_prefix": "*",<br>    "source_port_ranges": "*"<br>  },<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "AzureCloud",<br>    "destination_port_ranges": "443",<br>    "direction": "Outbound",<br>    "name": "AllowAzureCloudCommunicationOutBound",<br>    "priority": "110",<br>    "protocol": "Tcp",<br>    "source_address_prefix": "*",<br>    "source_port_ranges": "*"<br>  },<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "VirtualNetwork",<br>    "destination_port_ranges": "8080,5701",<br>    "direction": "Outbound",<br>    "name": "AllowBastionHostCommunicationOutBound",<br>  
  "priority": "120",<br>    "protocol": "*",<br>    "source_address_prefix": "VirtualNetwork",<br>    "source_port_ranges": "*"<br>  },<br>  {<br>    "access": "Allow",<br>    "destination_address_prefix": "Internet",<br>    "destination_port_ranges": "80,443",<br>    "direction": "Outbound",<br>    "name": "AllowGetSessionInformationOutBound",<br>    "priority": "130",<br>    "protocol": "*",<br>    "source_address_prefix": "*",<br>    "source_port_ranges": "*"<br>  },<br>  {<br>    "access": "Deny",<br>    "destination_address_prefix": "*",<br>    "destination_port_ranges": "*",<br>    "direction": "Outbound",<br>    "name": "DenyAllOutBound",<br>    "priority": "1000",<br>    "protocol": "*",<br>    "source_address_prefix": "*",<br>    "source_port_ranges": "*"<br>  }<br>]</pre> | no |
| <a name="input_bastion_publicip_name"></a> [bastion\_publicip\_name](#input\_bastion\_publicip\_name) | Bastion Public IP resource name | `string` | n/a | yes |
| <a name="input_bastion_subnet_id"></a> [bastion\_subnet\_id](#input\_bastion\_subnet\_id) | Please provide the subnet id for the Bastion to be deployed to | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Locaton to use for the deployment of resources | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name to deploy the resources into | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to associate with your resources | `map(string)` | <pre>{<br>  "ENV": "test"<br>}</pre> | no |

## Outputs

No outputs.
