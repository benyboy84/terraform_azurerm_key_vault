# Configure the minimum required providers supported
terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.54.0"
      configuration_aliases = [ 
        azurerm,
        azurerm.dns
       ]
    }
  }

  required_version = ">= 1.3.1"

}