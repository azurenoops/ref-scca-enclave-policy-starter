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
  backend "azurerm" {
    key = "ampe_policy"
  }
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
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id_hub
  features {}
}
