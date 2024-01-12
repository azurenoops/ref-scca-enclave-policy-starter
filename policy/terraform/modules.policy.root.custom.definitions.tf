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
module "mod_deploy_resource_diagnostic_setting_root_definition" {
  source  = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version = "~> 2.0"
  for_each = toset([
    "audit_log_analytics_workspace_retention",
    "audit_sub_diagnostic_setting_exist",      
  ])
  policy_def_name     = each.value
  policy_category     = "Monitoring"
  management_group_id = data.azurerm_management_group.root.id
}

#DenyAction
module "mod_deploy_denyaction_root_definition" {
  source  = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version = "~> 2.0"
  for_each = toset([
    "deny_action_activity_logs",
    "deny_action_diagnostic_logs",
  ])
  policy_def_name     = each.value
  policy_category     = "DenyAction"
  management_group_id = data.azurerm_management_group.root.id
}

####################
# Defender 
####################

# create definitions by calling them explicitly from a local (as above)
module "mod_deploy_defender_root_definition" {
  source  = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version = "~> 2.0"
  for_each = toset([
    "deploy_asc_security_contacts",
    "deploy_export_asc_alerts_and_recom_to_law",
    "deploy_provision_law_agent_custom_workspace",    
  ])
  policy_def_name     = each.value
  policy_category     = "Security"
  management_group_id = data.azurerm_management_group.root.id
}

####################
# Cost Management
####################

# create definitions by calling them explicitly from a local (as above)
module "mod_deploy_cost_management_root_definition" {
  source  = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version = "~> 2.0"
  for_each = toset([
    "deploy_budget",
    "audit_disks_unused_resources",
    "audit_publicIp_addresses_unused_resources",
    "audit_serverfarms_unused_resources",
  ])
  policy_def_name     = each.value
  policy_category     = "Cost"
  management_group_id = data.azurerm_management_group.root.id
}

####################
# SQL
####################
# create definitions by calling them explicitly from a local (as above)
module "mod_deploy_sql_root_definition" {
  source  = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version = "~> 2.0"
  for_each = toset([
    "deploy_sql_security_alert_policies",
    "deploy_sql_auditingsettings",
    "deploy_sql_min_tls",
    "deploy_sql_vulnerability_assessments",
  ])
  policy_def_name     = each.value
  policy_category     = "SQL"
  management_group_id = data.azurerm_management_group.root.id
} 

####################
# Tags
####################
# create definitions by calling them explicitly from a local (as above)
module "mod_deploy_tags_root_definition" {
  source  = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version = "~> 2.0"
  for_each = toset([
    "inherit_resource_group_tags_append",
  ])
  policy_def_name     = each.value
  policy_category     = "Tags"
  management_group_id = data.azurerm_management_group.root.id
}

################################
# Azure Monitor Baseline Alerts
################################

# create definitions by calling them explicitly from a local (as above)
module "mod_deploy_aa_totaljob_alert_root_definition" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version                = "~> 2.0"
  file_path              = "${path.cwd}/custompolicies/definitions/monitoring/deploy_aa_totaljob_alert.json"  
  management_group_id    = data.azurerm_management_group.root.id
}

module "mod_deploy_activitylog_la_del_root_definition" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version                = "~> 2.0"
  file_path              = "${path.cwd}/custompolicies/definitions/monitoring/deploy_activitylog_la_workspace_del.json"  
  management_group_id    = data.azurerm_management_group.root.id
}

module "mod_deploy_activitylog_la_keyregen_root_definition" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version                = "~> 2.0"
  file_path              = "${path.cwd}/custompolicies/definitions/monitoring/deploy_activitylog_la_workspace_keyregen.json"  
  management_group_id    = data.azurerm_management_group.root.id
}

module "mod_deploy_rv_backup_alert_root_definition" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version                = "~> 2.0"
  file_path              = "${path.cwd}/custompolicies/definitions/monitoring/modify_rsv_backuphealth_alert.json"  
  management_group_id    = data.azurerm_management_group.root.id
}

module "mod_deploy_sa_availability_alert_root_definition" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version                = "~> 2.0"
  file_path              = "${path.cwd}/custompolicies/definitions/monitoring/deploy_storageaccount_availability_alert.json"  
  management_group_id    = data.azurerm_management_group.root.id
}

module "mod_audit_user_role_assignments_definition" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version                = "~> 2.0"
  file_path              = "${path.cwd}/custompolicies/definitions/aad/audit_user_role_assignments.json"  
  management_group_id    = data.azurerm_management_group.root.id
}
