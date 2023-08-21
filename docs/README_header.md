# Azure Key Vault

Azure Key Vault is a tool for securely storing and accessing secrets, keys and certificates. 

This Terraform Module creates an Azure Key Vault with "reader" and "admin" pre-configured Access policies.

- If `enable_rbac_authorization` is set to `true`, it will assign objects ID to RBAC roles.

  | Input | Role(s) |
  |-------|---------|
  | reader_objects_ids | Key Vault Administrator |
  | admin_objects_ids | Key Vault Secrets User & Key Vault Reader |

- If `enable_rbac_authorization` is set to `false`, it will create access policy.

  | Input | Key Permissions | Secret Permissions | Certificate Permissions |
  |-------|-----------------|--------------------|-------------------------|
  | reader_objects_ids | Get<br>List | Get<br>List | Get<br>List |
  | admin_objects_ids | Backup<br>Create<br>Decrypt<br>Delete<br>Encrypt<br>Get<br>Import<br>List<br>Purge<br>Recover<br>Restore<br>Sign<br>UnwrapKey<br>Update<br>Verify<br>WrapKey<br> | Backup<br>Delete<br>Get<br>List<br>Purge<br>Recover<br>Restore<br>Set | Backup<br>Create<br>Delete<br>DeleteIssuers<br>Get<br>GetIssuers<br>Import<br>List<br>ListIssuers<br>ManageContacts<br>ManageIssuers<br>Purge<br>Recover<br>Restore<br>SetIssuers<br>Update |

## Module Usage

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "canadacentral"
}

data "azurerm_client_config" "this" {}

module "keyvault" {
  source = "https://github.com/benyboy84/terraform-azurerm-key_vault?ref=v1.0.0"

  name                            = "example"
  location                        = azurerm_resource_group.example.location
  resource_group_name             = azurerm_resource_group.example.name
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  admin_objects_ids               = [data.azurerm_client_config.this.object_id]
}
```