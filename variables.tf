variable "location" {
  type = string
  default = null
  description = "Locaton to use for the deployment of resources"
}
variable "resource_group_name" {
    type = string
    description = "Resource group name to deploy the resources into" 
}
variable "bastion_name" {
    type = string
    description = "Bastion resource name"
}
variable "bastion_subnet_id" {
    type = string
    description = "Please provide the subnet id for the Bastion to be deployed to"
}

variable "bastion_publicip_name" {
    type = string
    description = "Bastion Public IP resource name"
}

variable "bastion_nsg_name" {
    type = string
    description = "Bastion Public IP resource name"
}

variable "tags" {
  description = "The tags to associate with your resources"
  type        = map(string)

  default = {
    ENV = "test"
  }
}

variable "bastion_nsg_rules" {
    description = "NSG rules used for Azure Bastion Host"
    type = list(map(string))
    default = [
    {
        name                        = "AllowHttpsInBound"
        priority                    = "100"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_ranges           = "*"
        destination_port_ranges      = "443"
        source_address_prefix       = "Internet"
        destination_address_prefix  = "*"
    },
    {
        name                        = "AllowGatewayManagerInBound"
        priority                    = "110"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_ranges          = "*"
        destination_port_ranges     = "443"
        source_address_prefix       = "GatewayManager"
        destination_address_prefix  = "*"
    },
    {
        name                        = "AllowLoadBalancerInBound"
        priority                    = "120"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_ranges          = "*"
        destination_port_ranges     = "443"
        source_address_prefix       = "AzureLoadBalancer"
        destination_address_prefix  = "*"
    },
    {
        name                        = "AllowBastionHostCommunicationInBound"
        priority                    = "130"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "*"
        source_port_ranges          = "*"
        destination_port_ranges     = "8080,5701"
        source_address_prefix       = "VirtualNetwork"
        destination_address_prefix  = "VirtualNetwork"
    },
    {
        name                        = "DenyAllInBound"
        priority                    = "1000"
        direction                   = "Inbound"
        access                      = "Deny"
        protocol                    = "*"
        source_port_ranges          = "*"
        destination_port_ranges     = "*"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    },
    {
        name                        = "AllowSshRdpOutBound"
        priority                    = "100"
        direction                   = "Outbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_ranges          = "*"
        destination_port_ranges     = "22,3389"
        source_address_prefix       = "*"
        destination_address_prefix  = "VirtualNetwork"
    },
    {
        name                        = "AllowAzureCloudCommunicationOutBound"
        priority                    = "110"
        direction                   = "Outbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_ranges          = "*"
        destination_port_ranges     = "443"
        source_address_prefix       = "*"
        destination_address_prefix  = "AzureCloud"
    },
    {
        name                        = "AllowBastionHostCommunicationOutBound"
        priority                    = "120"
        direction                   = "Outbound"
        access                      = "Allow"
        protocol                    = "*"
        source_port_ranges          = "*"
        destination_port_ranges     = "8080,5701"
        source_address_prefix       = "VirtualNetwork"
        destination_address_prefix  = "VirtualNetwork"
    },
    {
        name                        = "AllowGetSessionInformationOutBound"
        priority                    = "130"
        direction                   = "Outbound"
        access                      = "Allow"
        protocol                    = "*"
        source_port_ranges          = "*"
        destination_port_ranges     = "80"
        source_address_prefix       = "*"
        destination_address_prefix  = "Internet"
    },
    {
        name                        = "DenyAllOutBound"
        priority                    = "1000"
        direction                   = "Outbound"
        access                      = "Deny"
        protocol                    = "*"
        source_port_ranges          = "*"
        destination_port_ranges     = "*"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    },
    ]
  
}

variable "bastion_diags_log_analytics_id" {
  description = "Log analytics workspace ID that will be used for storing Bastion diagnostic settings"
  type = string
  default = null
}