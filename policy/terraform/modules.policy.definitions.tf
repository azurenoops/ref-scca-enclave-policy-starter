# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy Policy Definitions for Azure Policy in Partner Environments
DESCRIPTION: The following components will be options in this deployment
             * Policy Definitions
AUTHOR/S: jspinella
*/

########################################
### Policy Definitions Configuations ###
########################################

##################
# Security Center
##################

# 
module "mod_configure_asc" {
  source  = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version = ">= 1.2"
  for_each = toset([
    "auto_enroll_subscriptions",
    "auto_provision_log_analytics_agent_custom_workspace",
    "auto_set_contact_details",
    "export_asc_alerts_and_recommendations_to_eventhub",
    "export_asc_alerts_and_recommendations_to_log_analytics",
  ])
  policy_def_name     = each.value
  policy_category     = "Security"
  management_group_id = data.azurerm_management_group.root.id
}

##################
# Monitoring
##################

# Deploy Diagnostic Settings for Azure Resources
module "mod_deploy_resource_diagnostic_setting" {
  source  = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version = ">= 1.2"
  for_each = toset([
    "audit_log_analytics_workspace_retention",
    "audit_subscription_diagnostic_setting_should_exist",
    "deploy_api_mgmt_diagnostic_setting",
    "deploy_vnet_diagnostic_setting",
    "deploy_public_ip_diagnostic_setting",
    "deploy_network_interface_diagnostic_setting",
    "deploy_storage_account_diagnostic_setting",
    "deploy_keyvault_diagnostic_setting",
    "deploy_firewall_diagnostic_setting",
    "deploy_network_security_group_diagnostic_setting",
    "deploy_virtual_machine_diagnostic_setting",
    "deploy_subscription_diagnostic_setting",
    "deploy_bastion_diagnostic_setting",
    "deploy_application_gateway_diagnostic_setting",
  ])
  policy_def_name     = each.value
  policy_category     = "Monitoring"
  management_group_id = data.azurerm_management_group.root.id
}

##################
# Network
##################

# Deny Public IP Addresses on Network 
module "mod_deny_public_ip_platforms" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version             = ">= 1.2"
  policy_def_name     = "deny_publicip"
  display_name        = "Platforms Network should not have public IPs"
  policy_category     = "Network"
  management_group_id = data.azurerm_management_group.platforms.id
}

# Deny Public IP Addresses on Network 
module "mod_deny_public_ip_workloads_internal" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version             = ">= 1.2"
  policy_def_name     = "deny_publicip"
  display_name        = "Internal Workloads Network should not have public IPs"
  policy_category     = "Network"
  management_group_id = data.azurerm_management_group.internal.id
}

module "mod_deny_public_ip_workloads_partners" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version             = ">= 1.2"
  policy_def_name     = "deny_publicip"
  display_name        = "Partners Workload Network should not have public IPs"
  policy_category     = "Network"
  management_group_id = data.azurerm_management_group.partners.id
}

##################
# Storage
##################
module "mod_storage_enforce_https" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version             = ">= 1.2"
  policy_def_name     = "storage_enforce_https"
  display_name        = "Secure transfer to storage accounts should be enabled"
  policy_category     = "Storage"
  policy_mode         = "Indexed"
  management_group_id = data.azurerm_management_group.root.id
}

module "mod_storage_enforce_minimum_tls1_2" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version             = ">= 1.2"
  policy_def_name     = "deny_storage_mintls"
  display_name        = "Minimum TLS version for data in transit to storage accounts should be set"
  policy_category     = "Storage"
  policy_mode         = "Indexed"
  management_group_id = data.azurerm_management_group.root.id
}


##################
# Tags
##################
module "mod_inherit_resource_group_tags_modify" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version             = ">= 1.2"
  policy_def_name     = "inherit_resource_group_tags_modify"
  display_name        = "Resources should inherit Resource Group Tags and Values with Modify Remediation"
  policy_category     = "Tags"
  policy_mode         = "Indexed"
  management_group_id = data.azurerm_management_group.root.id
}

resource "time_sleep" "after_azurerm_policy_definition" {
  depends_on = [
    //module.deploy_resource_diagnostic_setting,
    module.mod_deny_public_ip_platforms,
    module.mod_deny_public_ip_workloads_internal,
    module.mod_deny_public_ip_workloads_partners,
    //module.storage_enforce_https,
    //module.storage_enforce_minimum_tls1_2,
    module.mod_inherit_resource_group_tags_modify,
  ]

  triggers = {
    // "azurerm_policy_definition_noops" = jsonencode(keys(module.deploy_resource_diagnostic_setting))
    "azurerm_policy_definition_noops" = jsonencode(keys(module.mod_deny_public_ip_platforms))
    "azurerm_policy_definition_noops" = jsonencode(keys(module.mod_deny_public_ip_workloads_internal))
    "azurerm_policy_definition_noops" = jsonencode(keys(module.mod_deny_public_ip_workloads_partners))
    //"azurerm_policy_definition_noops" = jsonencode(keys(module.storage_enforce_https))
    //"azurerm_policy_definition_noops" = jsonencode(keys(module.storage_enforce_minimum_tls1_2))
    "azurerm_policy_definition_noops" = jsonencode(keys(module.mod_inherit_resource_group_tags_modify))
  }

  create_duration  = local.create_duration_delay["after_azurerm_policy_definition"]
  destroy_duration = local.destroy_duration_delay["after_azurerm_policy_definition"]
}
