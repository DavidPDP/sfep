terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.95.0"
    }
    /*github = {
      source  = "integrations/github"
      version = "6.0.1"
    }*/
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

/*provider "github" {
  owner = "safe-fleet"
  token = "<TOKEN>"
}*/