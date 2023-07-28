# ------------------------------------------------------------------------------
# Creating Private Endpoint
# ------------------------------------------------------------------------------

resource "azurerm_private_endpoint" "this" {
  count = var.private_endpoint_subnetid != null ? 1 : 0

  name                          = "${var.name}-pe"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  subnet_id                     = var.private_endpoint_subnetid
  custom_network_interface_name = "${var.name}-nic"
  tags                          = var.tags

  private_service_connection {
    name                           = "${var.name}-pe" 
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = ["vault"]
  }

  lifecycle {
    ignore_changes = [private_dns_zone_group]
  }

}

# ------------------------------------------------------------------------------
# Create DNS A Records within Azure Private DNS for `blob` private endpoint
# ------------------------------------------------------------------------------

resource "azurerm_private_dns_a_record" "blob" {
  count = var.private_endpoint_subnetid != null && var.dns_record != null ? 1 : 0

  provider            = azurerm.dns
  name                = var.name
  resource_group_name = var.dns_record.resource_group_name
  zone_name           = "privatelink.vaultcore.azure.net"
  ttl                 = var.dns_record.ttl
  records             = [azurerm_private_endpoint.this[0].private_service_connection[0].private_ip_address]
}
