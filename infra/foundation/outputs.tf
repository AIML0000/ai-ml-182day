output "resource_group" {
  value = azurerm_resource_group.ml.name
}

output "location" {
  value = azurerm_resource_group.ml.location
}

output "storage_account" {
  value = azurerm_storage_account.ml.name
}

output "key_vault_uri" {
  value = azurerm_key_vault.ml.vault_uri
}
