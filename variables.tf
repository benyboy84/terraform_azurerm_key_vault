# ------------------------------------------------------------------------------
# Key Vault
# ------------------------------------------------------------------------------

variable "name" {
  description = "Specifies the name of the Key Vault. Changing this forces a new resource to be created. The name must be globally unique. If the vault is in a recoverable state then the vault will need to be purged before reusing the name."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
  type        = string
}

variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are \"standard\" and \"premium\"."
  type        = string
  default     = "standard"


  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "Possible values are \"standard\" and \"premium\"."
  }
}

variable "enabled_for_deployment" {
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
  type        = bool
  default     = false
}

variable "enable_rbac_authorization" {
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  type        = bool
  default     = false
}

variable "network_acls" {
  description = "Network rules to apply to key vault."
  type = object({
    bypass                     = string,
    default_action             = string,
    ip_rules                   = optional(list(string)),
    virtual_network_subnet_ids = optional(list(string)),
  })
  default = null

}

variable "purge_protection_enabled" {
  description = "Is Purge Protection enabled for this Key Vault?"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for this Key Vault."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. This value can be between `7` and `90` days."
  type        = number
  default     = 7


  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "Retention days value can be between `7` and `90` days."
  }
}

variable "certificate_contacts" {
  description = "Contact information to send notifications triggered by certificate lifetime events."
  type = list(object({
    email = string
    name  = optional(string)
    phone = optional(string)
  }))
  default = []

  validation {
    condition = length([
      for contact in var.certificate_contacts : true
      if can(regex("^.*@.*\\..*$", contact.email))
    ]) == length(var.certificate_contacts)
    error_message = "email address is not in the right format"
  }
}

variable "tags" {
  description = "Tags to apply on Key Vault resource."
  type        = map(string)
  default     = {}
}

variable "admin_objects_ids" {
  description = "IDs of the objects that can do all operations on all keys, secrets and certificates."
  type        = list(string)
  default     = []

  validation {
    condition = length([
      for id in var.admin_objects_ids : true
      if can(regex("^[a-f\\d]{4}(?:[a-f\\d]{4}-){4}[a-f\\d]{12}$", id))
    ]) == length(var.admin_objects_ids)
    error_message = "Admin Objects IDs must contains GUID."
  }

}

variable "reader_objects_ids" {
  description = "IDs of the objects that can read all keys, secrets and certificates."
  type        = list(string)
  default     = []

  validation {
    condition = length([
      for id in var.reader_objects_ids : true
      if can(regex("^[a-f\\d]{4}(?:[a-f\\d]{4}-){4}[a-f\\d]{12}$", id))
    ]) == length(var.reader_objects_ids)
    error_message = "Reader Objects IDs must contains GUID."
  }
}

#---------------------------------------------------------
# Private Endpoint for Key Vault
#---------------------------------------------------------

variable "enable_private_endpoint" {
  description = "Whether to use private endpoint with the Azure Key Vault."
  type        = bool
  default     = true
}

variable "private_endpoint_subnet" {
  description = "Network information required to create a private endpoint."
  type = object({
    virtual_network_name = string
    name                 = string
    resource_group_name  = string
  })
  default = null
}
