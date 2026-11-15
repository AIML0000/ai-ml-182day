resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

data "azurerm_client_config" "current" {}

# On your personal account you're the Owner, so Terraform creates the RG itself.
resource "azurerm_resource_group" "ml" {
  name     = "${var.prefix}-rg"
  location = var.location

  tags = {
    purpose = "ai-ml-182day"
    owner   = "thrilochana"
  }
}

resource "azurerm_storage_account" "ml" {
  name                     = "${var.prefix}sa${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.ml.name
  location                 = azurerm_resource_group.ml.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  tags                     = azurerm_resource_group.ml.tags
}

resource "azurerm_key_vault" "ml" {
  name                       = "${var.prefix}-kv-${random_string.suffix.result}"
  resource_group_name        = azurerm_resource_group.ml.name
  location                   = azurerm_resource_group.ml.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  # Modern RBAC data-plane auth (you're Owner, so you can create role assignments).
  rbac_authorization_enabled = true
}

# Grant yourself rights to manage secrets in this vault.
resource "azurerm_role_assignment" "kv_secrets" {
  scope                = azurerm_key_vault.ml.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "demo" {
  name         = "demo-api-key"
  value        = "placeholder-rotate-me"
  key_vault_id = azurerm_key_vault.ml.id

  # The role assignment must exist before we can write a secret.
  depends_on = [azurerm_role_assignment.kv_secrets]
}
