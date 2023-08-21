# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------

output "keyvault" {
  description = "Azure Key Vault resource."
  value       = azurerm_key_vault.this
}

output "id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.this.id
}

output "uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.this.uri
}