# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy Policy Definitions for Azure Policy in the Transport Management Group
DESCRIPTION: The following components will be options in this deployment
             * Policy Definitions
AUTHOR/S: jspinella
*/

##################################################
### Transport Policy Definitions Configuations ###
##################################################

##################
# Logging
##################

module "mod_transport_deploy_provision_law_agent_custom_workspace_policy_definition" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version                = "~> 2.0"
  policy_def_name        = "deploy_provision_law_agent_custom_workspace"
  display_name           = "Deploy and provision Log Analytics agent with custom workspace"
  policy_def_description = "This policy enables Security Center's auto provisioning of the Log Analytics agent on your subscriptions with custom workspace."
  policy_category        = "Security"
  management_group_id    = data.azurerm_management_group.transport.id
}

module "mod_transport_audit_log_analytics_workspace_retention_policy_definition" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version                = "~> 2.0"
  policy_def_name        = "audit_log_analytics_workspace_retention"
  display_name           = "Audit Log Analytics Workspace Retention"
  policy_def_description = "This policy ensures that Log Analytics workspaces has a retention period."
  policy_category        = "Monitoring"
  management_group_id    = data.azurerm_management_group.transport.id
}
