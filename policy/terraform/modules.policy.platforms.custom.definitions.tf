# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy Policy Definitions for Azure Policy in the Platforms Management Group
DESCRIPTION: The following components will be options in this deployment
             * Policy Definitions
AUTHOR/S: jspinella
*/

##################################################
### Platforms Policy Definitions Configuations ###
##################################################

####################
# Monitoring
####################

# create definitions by calling them explicitly from a local (as above)
/* module "deploy_resource_ama_alerts" {
  source  = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version = "~> 2.0"
  for_each = toset([
    "audit_log_analytics_workspace_retention",
    "audit_subscription_diagnostic_setting_should_exist",    
  ])
  policy_def_name     = each.value
  policy_category     = "Monitoring"
  management_group_id = data.azurerm_management_group.platforms.id
} */

##################
# Network
##################

/* module "deploy_platforms_network_configurations_policy_definition" {
  source  = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version = "~> 2.0"
  for_each = toset([
    "audit_log_analytics_workspace_retention",
    "audit_subscription_diagnostic_setting_should_exist",    
  ])
  policy_def_name     = each.value
  policy_category     = "Network"
  management_group_id = data.azurerm_management_group.platforms.id
} */
