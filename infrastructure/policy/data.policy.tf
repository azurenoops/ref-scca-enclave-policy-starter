# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

##################
### DATA       ###
##################

data "azurerm_subscription" "current" {}
data "azuread_client_config" "current" {}

# Root Management Group
data "azurerm_management_group" "root" {
  name = "anoa"
}

data "azurerm_management_group" "sandbox" {
  name = "sandbox"
}

# Platforms Management Group
data "azurerm_management_group" "platforms" {
  name = "platforms"
}

data "azurerm_management_group" "transport" {
  name = "transport"
}

data "azurerm_management_group" "security" {
  name = "security"
}

data "azurerm_management_group" "identity" {
  name = "identity"
}

data "azurerm_management_group" "forensic" {
  name = "forensic"
}

# Workloads Management Group
data "azurerm_management_group" "workloads" {
  name = "workloads"
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

# Monitoring Contributor role
data "azurerm_role_definition" "monitoring_contributor" {
  name = "Monitoring Contributor"
}

# Log Analytics Contributor role
data "azurerm_role_definition" "law_contributor" {
  name = "Log Analytics Contributor"
}

# Log Analytics Contributor role
data "azurerm_role_definition" "st_contributor" {
  name = "Storage Account Contributor"
}

# Security Admin role
data "azurerm_role_definition" "security_admin_contributor" {
  name = "Security Admin"
}

data "azurerm_log_analytics_workspace" "anoa_laws" {
  name                = "anoa-eus-ops-logging-prod-log"
  resource_group_name = "anoa-eus-ops-logging-prod-rg"
}

data "azurerm_storage_account" "anoa_laws_storage" {
  name                = "anoaeusd17a3dprodst"
  resource_group_name = "anoa-eus-ops-logging-prod-rg"
}

data "azurerm_storage_account" "anoa_hub_storage" {
  name                = "anoaeus566bdc765cprodst"
  resource_group_name = "anoa-eus-hub-core-prod-rg"
}



