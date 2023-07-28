#---------------------------------------------------------
# Assigning objects ids to RBAC roles: 
#  - rbac_keyvault_administrator
#  - rbac_keyvault_secrets_users
#  - rbac_keyvault_reader
#---------------------------------------------------------

resource "azurerm_role_assignment" "rbac_keyvault_administrator" {
  for_each = toset(var.enable_rbac_authorization ? var.admin_objects_ids : [])

  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = each.value

}

resource "azurerm_role_assignment" "rbac_keyvault_secrets_users" {
  for_each = toset(var.enable_rbac_authorization ? var.reader_objects_ids : [])

  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "rbac_keyvault_reader" {
  for_each = toset(var.enable_rbac_authorization ? var.reader_objects_ids : [])

  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Reader"
  principal_id         = each.value
}
