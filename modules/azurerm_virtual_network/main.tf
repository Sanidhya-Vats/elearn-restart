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
}