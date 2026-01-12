resource "azurerm_key_vault" "key_vault" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = var.sku_name

  enable_rbac_authorization   = true
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled

  public_network_access_enabled = var.public_network_access_enabled
  


//TODO- Enable when private endpoint support is needed  
#   public_network_access_enabled = var.enable_private_endpoint ? false : var.public_network_access_enabled
#   dynamic "network_acls" {
#     for_each = var.network_acls == null ? [] : [var.network_acls]
#     content {
#       default_action = network_acls.value.default_action
#       bypass         = network_acls.value.bypass
#       ip_rules       = network_acls.value.ip_rules
#       virtual_network_subnet_ids = network_acls.value.subnet_ids
#     }
#   }

  tags = var.tags
}

# RBAC assignments
resource "azurerm_role_assignment" "kv_roles" {
  for_each             = var.role_assignments
  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = each.value.role_name
  principal_id         = each.value.principal_id
}
