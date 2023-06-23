# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

##################
### DATA       ###
##################

data "azurerm_subscription" "current" {}

# Org Management Group
data "azurerm_management_group" "root" {
  name = "ampe"
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
  name                = "ampe-eus-policy-remediator-ai"
  resource_group_name = "afmpe-network-artifacts-rg"
}

data "azuread_group" "ampe_policy_remediation" {
  display_name     = "ampe_policy_remediation"
  security_enabled = true
}

data "azurerm_log_analytics_workspace" "ampe_laws" {
  name                = "ampe-eus-ops-logging-core-prod-log"
  resource_group_name = "ampe-eus-ops-logging-core-prod-rg"
}

data "azurerm_storage_account" "logging_storage_account" {
  name                = "ampeeus264794eccaafa2f0"
  resource_group_name = "ampe-eus-ops-logging-core-prod-rg"
}