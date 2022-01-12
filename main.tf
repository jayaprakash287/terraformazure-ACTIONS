terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}



resource "azurerm_network_security_group" "example" {
  name                = "example-security-group"
  location            = "westus2"
  resource_group_name = "rd-poc-hasthijaya"
}

resource "azurerm_virtual_network" "vnet" {
    name                = "virtual_net"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]
    location            = "westus2"
    resource_group_name = "rd-poc-hasthijaya"


  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.example.id
  }

    tags = {
    environment = "Denops"
  }
}
