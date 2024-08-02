# We will define 
# 1. Terraform Settings Block
# 1. Required Version Terraform
# 2. Required Terraform Providers
# 3. Terraform Remote State Storage with Azure Storage Account (last step of this section)
# 2. Terraform Provider Block for AzureRM
# 3. Terraform Resource Block: Define a Random Pet Resource

# 1. Terraform Settings Block
terraform {
  # 1. Required Version Terraform
  required_version = ">= 0.13"
  # 2. Required Terraform Providers  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

# Terraform State Storage to Azure Storage Container
  backend "azurerm" {
    #resource_group_name   = "terraform-storage-rg"
    #storage_account_name  = "terraformstatexlrwdrzs"
    #container_name        = "tfstatefiles"
    #key                   = "terraform-custom-vnet.tfstate"
  }  
}



# 2. Terraform Provider Block for AzureRM
provider "azurerm" {
  features {

  }
}

# 3. Terraform Resource Block: Define a Random Pet Resource
resource "random_pet" "aksrandom" {

}
# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "myrg" {
  name = "myrg-1"
  location = "East US"
}
# Resource-2: Create Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name                = "myvnet-1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  tags = {
    "Name" = "myvnet-1"
    #"Environment" = "Dev"  # Uncomment during Step-10
  }
}
