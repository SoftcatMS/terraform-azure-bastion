data "azurerm_resource_group" "bastion" {
  name = var.resource_group_name
}

resource "azurerm_network_security_group" "bastion_nsg" {
    name = var.bastion_nsg_name
    location = var.location != null ? var.location : data.azurerm_resource_group.bastion.location
    resource_group_name = data.azurerm_resource_group.bastion.name
    tags = var.tags

    dynamic "security_rule" {
        for_each = [for s in var.bastion_nsg_rules : {
                name                        = s.name
                priority                    = s.priority
                direction                   = s.direction
                access                      = s.access
                protocol                    = s.protocol
                source_port_ranges          = split(",", replace(s.source_port_ranges, "*", "0-65535"))
                destination_port_ranges     = split(",", replace(s.destination_port_ranges, "*", "0-65535"))
                source_address_prefix       = s.source_address_prefix
                destination_address_prefix  = s.destination_address_prefix
        }]
        content {
                name                        = security_rule.value.name
                priority                    = security_rule.value.priority
                direction                   = security_rule.value.direction
                access                      = security_rule.value.access
                protocol                    = security_rule.value.protocol
                source_port_ranges          = security_rule.value.source_port_ranges
                destination_port_ranges     = security_rule.value.destination_port_ranges
                source_address_prefix       = security_rule.value.source_address_prefix
                destination_address_prefix  = security_rule.value.destination_address_prefix
        }
    }
}
resource "azurerm_subnet_network_security_group_association" "bastion_nsg" {
    subnet_id = var.bastion_subnet_id
    network_security_group_id = azurerm_network_security_group.bastion_nsg.id
}

resource "azurerm_public_ip" "bastion" {
  name = var.bastion_publicip_name
  resource_group_name = data.azurerm_resource_group.bastion.name
  location = var.location != null ? var.location : data.azurerm_resource_group.bastion.location
  allocation_method = "Static"
  sku = "Standard"
  tags = var.tags

}

resource "azurerm_bastion_host" "bastion" {
  name = var.bastion_name
  resource_group_name = data.azurerm_resource_group.bastion.name
  location = var.location != null ? var.location : data.azurerm_resource_group.bastion.location
  tags = var.tags

  ip_configuration {
    name = "BastionPubIP"
    subnet_id = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
  
}

resource "azurerm_monitor_diagnostic_setting" "bastion" {
  name  = "Bastion_Audit_Logs"
  target_resource_id = azurerm_bastion_host.bastion.id
  log_log_analytics_workspace_id = var.bastion_diags_log_analytics_id
  log {
    category = "BastionAuditLogs"
    enabled  = "true"
  }

}