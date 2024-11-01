# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

##################
### DATA       ###
##################

data "azurerm_subscription" "current" {}
data "azuread_client_config" "current" {}

# Root Management Group
data "azurerm_management_group" "root" {
  name = var.org_name
}

data "azurerm_management_group" "sandbox" {
  count = var.settings.sandbox_management_group_policies.enabled  && !var.settings.sandbox_management_group_policies.create ? 1 : 0
  name = var.settings.sandbox_management_group_policies.name
}

resource "azurerm_management_group" "sandbox" {
  count = var.settings.sandbox_management_group_policies.enabled  && var.settings.sandbox_management_group_policies.create ? 1 : 0
  name = var.settings.sandbox_management_group_policies.name
  parent_management_group_id = data.azurerm_management_group.root.id
}

# Platforms Management Group
data "azurerm_management_group" "platforms" {
  count = var.settings.platforms_management_group_policies.enabled  && !var.settings.platforms_management_group_policies.create ? 1 : 0
  name = var.settings.platforms_management_group_policies.name
}

resource "azurerm_management_group" "platforms" {
  count = var.settings.platforms_management_group_policies.enabled  && var.settings.platforms_management_group_policies.create ? 1 : 0
  name = var.settings.platforms_management_group_policies.name
  parent_management_group_id = data.azurerm_management_group.root.id
}

data "azurerm_management_group" "transport" {
  count = var.settings.transport_management_group_policies.enabled  && !var.settings.transport_management_group_policies.create ? 1 : 0
  name = var.settings.transport_management_group_policies.name
}

resource "azurerm_management_group" "transport" {
  count = var.settings.transport_management_group_policies.enabled  && var.settings.transport_management_group_policies.create ? 1 : 0
  name = var.settings.transport_management_group_policies.name
  parent_management_group_id = data.azurerm_management_group.root.id
}



data "azurerm_management_group" "devsecops" {
  count = var.settings.devsecops_management_group_policies.enabled  && !var.settings.devsecops_management_group_policies.create ? 1 : 0
  name = var.settings.devsecops_management_group_policies.name
}

resource "azurerm_management_group" "devsecops" {
  count = var.settings.devsecops_management_group_policies.enabled  && var.settings.devsecops_management_group_policies.create ? 1 : 0
  name = var.settings.devsecops_management_group_policies.name
  parent_management_group_id = data.azurerm_management_group.root.id
}

data "azurerm_management_group" "security" {
  count = var.settings.security_management_group_policies.enabled  && !var.settings.security_management_group_policies.create ? 1 : 0
  name = var.settings.security_management_group_policies.name
}

resource "azurerm_management_group" "security" {
  count = var.settings.security_management_group_policies.enabled  && var.settings.security_management_group_policies.create ? 1 : 0
  name = var.settings.security_management_group_policies.name
  parent_management_group_id = data.azurerm_management_group.root.id
}

data "azurerm_management_group" "identity" {
  count = var.settings.identity_management_group_policies.enabled  && !var.settings.identity_management_group_policies.create ? 1 : 0
  name = var.settings.identity_management_group_policies.name
}

resource "azurerm_management_group" "identity" {
  count = var.settings.identity_management_group_policies.enabled  && var.settings.identity_management_group_policies.create ? 1 : 0
  name = var.settings.identity_management_group_policies.name
  parent_management_group_id = data.azurerm_management_group.root.id
}

data "azurerm_management_group" "forensic" {
  count = var.settings.forensic_management_group_policies.enabled  && !var.settings.forensic_management_group_policies.create ? 1 : 0
  name = var.settings.forensic_management_group_policies.name
}

resource "azurerm_management_group" "forensic" {
  count = var.settings.forensic_management_group_policies.enabled  && var.settings.forensic_management_group_policies.create ? 1 : 0
  name = var.settings.forensic_management_group_policies.name
  parent_management_group_id = data.azurerm_management_group.root.id
}

# Workloads Management Group
/*
data "azurerm_management_group" "workloads" {
  name = "workloads"
}

data "azurerm_management_group" "internal" {
  name = "internal"
}

data "azurerm_management_group" "partners" {
  name = "partners"
}
*/
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
  count = !var.settings.workspace.create ? 1 : 0
  name = var.settings.workspace.name
  resource_group_name = var.settings.workspace.resource_group.name
}

resource "azurerm_log_analytics_workspace" "anoa_laws" {
  count = var.settings.workspace.create ? 1 : 0
  name = var.settings.workspace.name
  resource_group_name = var.settings.workspace.resource_group.name
  location = var.default_location
}

data "azurerm_storage_account" "anoa_laws_storage" {
  count = !var.settings.workspace.workspace_storage.create ? 1 : 0
  name                = var.settings.workspace.workspace_storage.name
  resource_group_name = var.settings.workspace.resource_group.name
}

resource "azurerm_storage_account" "anoa_laws_storage" {
  count = var.settings.workspace.workspace_storage.create ? 1 : 0
  name                = var.settings.workspace.workspace_storage.name
  resource_group_name = var.settings.workspace.resource_group.name
  location = var.default_location
  account_tier = var.settings.workspace.workspace_storage.account_tier
  account_replication_type = var.settings.workspace.workspace_storage.account_replication_type
}

data "azurerm_storage_account" "anoa_hub_storage" {
    count = !var.settings.workspace.hub_storage.create ? 1 : 0
  name                = var.settings.workspace.hub_storage.name
  resource_group_name = var.settings.workspace.resource_group.name
}




resource "azurerm_storage_account" "anoa_hub_storage" {
  count = var.settings.workspace.hub_storage.create ? 1 : 0
  name                = var.settings.workspace.hub_storage.name
  resource_group_name = var.settings.workspace.resource_group.name
  location = var.default_location
  account_tier = var.settings.workspace.hub_storage.account_tier
  account_replication_type = var.settings.workspace.hub_storage.account_replication_type
}


