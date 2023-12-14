# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

##################
### DATA       ###
##################

data "azurerm_subscription" "current" {}
data "azuread_client_config" "current" {}

# Org Management Group
data "azurerm_management_group" "root" {
  name = "anoa"
}

data "azurerm_management_group" "platforms" {
  name = "platforms"
}

data "azurerm_management_group" "internal" {
  name = "internal"
}

data "azurerm_management_group" "partners" {
  name = "partners"
}

# User Defined Identity
data "azurerm_user_assigned_identity" "policy_rem" {
  name                = "anoa-usgva-policy-rem-id"
  resource_group_name = "anoa-usgva-hub-core-dev-rg"
}

# Contributor role
data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

# Virtual Machine Contributor role
data "azurerm_role_definition" "vm_contributor" {
  name = "Virtual Machine Contributor"
}

data "azurerm_log_analytics_workspace" "anoa_laws" {
  name                = "anoa-usgva-ops-mgt-logging-dev-log"
  resource_group_name = "anoa-usgva-ops-mgt-logging-dev-rg"
}

data "azurerm_storage_account" "logging_storage_account" {
  name                = "anoausgva9625b51a28devst"
  resource_group_name = "anoa-usgva-hub-core-dev-rg"
}

