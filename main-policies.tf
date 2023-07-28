#---------------------------------------------------------
# Creating "reader" and "admin" Access policies 
#---------------------------------------------------------

resource "azurerm_key_vault_access_policy" "readers_policy" {
  for_each = toset(var.enable_rbac_authorization ? [] : var.reader_objects_ids)

  object_id    = each.value
  tenant_id    = data.azurerm_client_config.this.tenant_id
  key_vault_id = azurerm_key_vault.this.id

  key_permissions = [
    "Get",
    "List",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]

  certificate_permissions = [
    "Get",
    "List",
  ]

}

resource "azurerm_key_vault_access_policy" "admin_policy" {
  for_each = toset(var.enable_rbac_authorization ? [] : var.admin_objects_ids)

  object_id    = each.value
  tenant_id    = data.azurerm_client_config.this.tenant_id
  key_vault_id = azurerm_key_vault.this.id

  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
    "Release",
    "Rotate",
    "GetRotationPolicy",
    "SetRotationPolicy",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]

  certificate_permissions = [
    "Backup",
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "Purge",
    "Recover",
    "Restore",
    "SetIssuers",
    "Update",
  ]

}
