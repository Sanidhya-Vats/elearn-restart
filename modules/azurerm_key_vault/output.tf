output "key_vault_id" {
  value = azurerm_key_vault.key_vault.id
}

output "key_vault_name" {
  value = azurerm_key_vault.key_vault.name
}



//TODO : DNS endpoint (URL) when private endpoint is implemented
  # output "key_vault_uri" {
  #   value = azurerm_key_vault.this.vault_uri
  # }
