# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy Policy Definitions for Azure Policy in the Root Management Group. Everything in this module is a custom policy definition.
DESCRIPTION: The following components will be options in this deployment
             * Policy Definitions
AUTHOR/S: jspinella
*/

###############################################
### Custom Policy Definitions Configuations ###
###############################################

####################
# Monitoring
####################
# create definitions by calling them explicitly from a local (as above)
module "deploy_resource_diagnostic_setting" {
  source  = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version = "~> 2.0"
  for_each = toset([
    "audit_log_analytics_workspace_retention",
    "audit_subscription_diagnostic_setting_should_exist",
    "deploy_aci_diagnostic_setting",
    "deploy_acr_diagnostic_settings",
    "deploy_api_mgmt_diagnostic_setting",
    "deploy_application_gateway_diagnostic_setting",
    "deploy_bastion_diagnostic_setting",
    "deploy_expressroute_diagnostic_setting",
    "deploy_firewall_diagnostic_setting",
    "deploy_frontdoor_diagnostic_setting",
    "deploy_function_diagnostics_setting",
    "deploy_loadbalancer_diagnostic_setting",
    "deploy_logAnalytics_diagnostics_setting",
    "deploy_network_interface_diagnostic_setting",
    "deploy_public_ip_diagnostic_setting",
    "deploy_redis_diagnostics_setting",
    "deploy_storage_account_diagnostic_setting",
    "deploy_sql_diagnostic_setting",
    "deploy_subscription_diagnostic_setting",
    "deploy_vnet_diagnostic_setting",
    "deploy_virtual_machine_diagnostic_setting",
    "deploy_vmss_diagnostic_setting",
    "deploy_vnet_gateway_diagnostic_setting",
    "deploy_webapp_diagnostic_setting",
  ])
  policy_def_name     = each.value
  policy_category     = "Monitoring"
  management_group_id = data.azurerm_management_group.root.id
}


####################
# Cost Management
####################

# create definitions by calling them explicitly from a local (as above)
module "deploy_cost_management_policy_definition" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version             = "~> 2.0"
  policy_def_name     = "deploy_budget"
  policy_category     = "Cost Management"
  management_group_id = data.azurerm_management_group.root.id
}
