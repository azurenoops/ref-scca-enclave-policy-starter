# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

##################
### DATA       ###
##################

data "azurerm_subscription" "current" {}

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

# Contributor role
data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

# Virtual Machine Contributor role
data "azurerm_role_definition" "vm_contributor" {
  name = "Virtual Machine Contributor"
}

# User Assigned Managed Identity
data "azurerm_user_assigned_identity" "policy_rem" {
  name                = "policy_remediator_mi"
  resource_group_name = "anoa-eus-hub-core-test-rg"
}

data "azuread_group" "anoa_policy_remediation" {
  display_name     = "anoa_policy_remediation"
  security_enabled = true
}

data "azurerm_log_analytics_workspace" "anoa_laws" {
  name                = "anoa-eus-ops-logging-core-test-log"
  resource_group_name = "anoa-eus-ops-logging-core-test-rg"
}

data "azurerm_storage_account" "logging_storage_account" {
  name                = "anoaeus64fa2d1ba78d5496st"
  resource_group_name = "anoa-eus-ops-logging-core-test-rg"
}