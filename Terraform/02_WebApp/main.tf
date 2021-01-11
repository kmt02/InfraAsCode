provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}

resource "azurerm_resource_group" "ngankam" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags = {
        Environment = "Terraform Getting Started"
        Team = "DevOps"
    }
}

resource "azurerm_app_service_plan" "ngankam" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.ngankam.location
  resource_group_name = azurerm_resource_group.ngankam.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "ngankam" {
  name                = var.app_service_name
  location            = azurerm_resource_group.ngankam.location
  resource_group_name = azurerm_resource_group.ngankam.name
  app_service_plan_id = azurerm_app_service_plan.ngankam.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}