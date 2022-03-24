resource "azurerm_resource_group" "rg-bastion-test-basic" {
  name     = "rg-bastion-test-basic"
  location = "uksouth"
}

module "vnet" {
  source              = "github.com/SoftcatMS/terraform-azure-vnet"
  vnet_name           = "bastion-test-vnet-basic"
  resource_group_name = azurerm_resource_group.rg-bastion-test-basic.name
  address_space       = ["10.1.0.0/16"]
  subnet_prefixes     = ["10.1.1.0/24"]
  subnet_names        = ["AzureBastionSubnet"]

  tags = {
    environment = "test"
    engineer    = "ci/cd"
  }
  depends_on = [azurerm_resource_group.rg-bastion-test-basic]
}

module "bastion" {
  source                = "../../"
  bastion_name          = "bastion-test-vm-basic"
  resource_group_name   = azurerm_resource_group.rg-bastion-test-basic.name
  bastion_subnet_id     = module.vnet.vnet_subnets[0]
  bastion_publicip_name = "bastion-test-basic-vm-pubip"
  bastion_nsg_name      = "bastion-test-vm-basic-nsg"

  tags = {
    environment = "test"
    engineer    = "ci/cd"
  }
  depends_on = [module.vnet]
}
