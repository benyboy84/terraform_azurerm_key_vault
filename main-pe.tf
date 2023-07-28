#---------------------------------------------------------
# Creating Private Endpoint
#---------------------------------------------------------

# Get Networking Data for a Private Endpoint
data "azurerm_subnet" "this" {
  count = var.private_endpoint_subnet != null ? 1 : 0

  name                 = var.private_endpoint_subnet.name
  virtual_network_name = var.private_endpoint_subnet.virtual_network_name
  resource_group_name  = var.private_endpoint_subnet.resource_group_name

}

# Private Endpoint Creation or selection
resource "azurerm_private_endpoint" "this" {
  count = var.private_endpoint_subnet != null ? 1 : 0

  name                          = "${var.name}-pe"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  subnet_id                     = data.azurerm_subnet.this[0].id
  custom_network_interface_name = "${var.name}-nic"
  tags = merge(var.tags, {
    creation_date        = "${time_static.this.year}-${time_static.this.month}-${time_static.this.day}"
    managed_by_terraform = "true"
  })

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
