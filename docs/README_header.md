1. The module deploys an Azure Key Vault
2. Configure access to the Key Vault. You need to specify the object who create the Key Vault will be assign in with admin. Without this, it will not be able to add anything to the vault.
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

3. Create a `Private Endpoint` for the Key Vault if `enable_private_endpoint` is set to `true`.
