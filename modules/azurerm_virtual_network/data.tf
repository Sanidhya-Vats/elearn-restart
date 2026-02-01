data "azurerm_network_security_group" "nsg" {
  // Create a NSG data source only for subnets that have network_security_group_name defined
  for_each = {
    for k, v in var.subnets :
    k => v
    if try(v.network_security_group_name, null) != null
  }

  name                = each.value.network_security_group_name
  resource_group_name = var.resource_group_name
}