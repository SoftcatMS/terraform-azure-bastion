resource "azurerm_resource_group" "example" {
  name     = "rg-example-bastion"
  location = "uksouth"
}

module "vnet" {
  source              = "github.com/SoftcatMS/terraform-azure-vnet"
  vnet_name           = "example-vnet"
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.1.0.0/16"]
  subnet_prefixes     = ["10.1.1.0/24"]
  subnet_names        = ["AzureBastionSubnet"]

  tags = {
    environment = "example"
    engineer    = "ci/cd"
  }
  depends_on = [azurerm_resource_group.example]
}

module "bastion" {
  source                = "github.com/SoftcatMS/terraform-azure-bastion"
  bastion_name          = "example-bastion"
  resource_group_name   = azurerm_resource_group.example.name
  bastion_subnet_id     = module.vnet.vnet_subnets[0]
  bastion_publicip_name = "example-bastion-pubip"
  bastion_nsg_name      = "example-bastion-nsg"

  tags = {
    environment = "example"
    engineer    = "ci/cd"
  }
  depends_on = [module.vnet]
}