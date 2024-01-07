# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy an SCCA Compliant Mission Partner Environment
DESCRIPTION: The following components will be options in this deployment
            * Mission Enclave - Policy Definitions
            * Mission Enclave - Policy Assignments
            * Mission Enclave - Role Definitions
AUTHOR/S: jspinella
*/

terraform {
  # It is recommended to use remote state instead of local
  backend "local" {}
  # If you are using Azure Storage, You can update these values in order to configure your remote state. backend.conf is not required for local backend.
  #backend "azurerm" {    
  #  key                  = "anoa"
  #}
  # If you are using Terraform Cloud, You can update these values in order to configure your remote state.
  /*  backend "remote" {
    organization = "{{ORGANIZATION_NAME}}"
    workspaces {
      name = "{{WORKSPACE_NAME}}"
    }
  }
  */

  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.36"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    null = {
      source = "hashicorp/null"
    }
    random = {
      version = "= 3.4.3"
      source  = "hashicorp/random"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.8.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  subscription_id            = var.subscription_id
  environment                = var.environment
  skip_provider_registration = var.environment == "usgovernment" ? true : false
  features {}
}

provider "azurerm" {
  alias                      = "hub"
  subscription_id            = var.subscription_id
  environment                = var.environment
  skip_provider_registration = var.environment == "usgovernment" ? true : false
  features {}
}
