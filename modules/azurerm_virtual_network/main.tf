resource "azurerm_resource_group" "rg" {   
  count = var.resource_group_name==null ? 1 : 0
  name     = replace(var.virtual_network_name, "-vnet", "-rg")
  location = var.location
  tags = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name==null ? azurerm_resource_group.rg[0].name : var.resource_group_name
  tags                = var.tags
  dynamic "subnet"  {
    for_each = var.subnets
    content {
      name = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
      // Associate NSG if defined in subnet variable or fetched from data source
      security_group = try(subnet.value.security_group_id, data.azurerm_network_security_group.nsg[subnet.key].id, null)
      private_endpoint_network_policies = subnet.value.private_endpoint_network_policies
      private_link_service_network_policies_enabled =subnet.value.private_link_service_network_policies_enabled
      
      dynamic "delegation" {
        for_each = subnet.value.delegation != null ? [subnet.value.delegation] : []
        content {
          
        name = delegation.value.delegation_name
        service_delegation {
          name = subnet.value.delegation.name
          actions = subnet.value.delegation.actions
        }
      }
      }
    }
    
  }
}