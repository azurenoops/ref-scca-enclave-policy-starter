
/*
SUMMARY: Module to deploy Policy Initiatives for Azure Policy in the Root Management Group
DESCRIPTION: The following components will be options in this deployment
             * Policy Initiatives
AUTHOR/S: jspinella
*/

###################################################
### Policy Initiative Initiatives Configuations ###
###################################################

####################
# General
####################

# Configures all the General settings, such as Allowed Virtual Machine Sizes
module "mod_deploy_general_config_root_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_general_config"
  initiative_display_name = "General Governance"
  initiative_description  = "This policy set configures all the General settings, such as Allowed Virtual Machine Sizes, Allowed Regions, and Not Allowed Resource Types"
  initiative_category     = "General"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    data.azurerm_policy_definition.allowed_regions,
    data.azurerm_policy_definition.allowed_virtual_machine_sizes,
  ]
}

######################
# Defender for Cloud
######################

# Configures all the MDFC settings, such as Microsoft Defender for Cloud 
# per individual service, security contacts, and export from MDFC to Log Analytics workspace
module "mod_deploy_defender_root_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_MDFC_config"
  initiative_display_name = "Security Governance"
  initiative_description  = "This policy set configures all the MDFC settings, such as Microsoft Defender for Cloud per individual service, Security contacts, and export from MDFC to Log Analytics workspace"
  initiative_category     = "Security Center"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_deploy_defender_root_definition["deploy_asc_security_contacts"].definition,
    module.mod_deploy_defender_root_definition["deploy_export_asc_alerts_and_recom_to_law"].definition,
    module.mod_deploy_defender_root_definition["deploy_provision_law_agent_custom_workspace"].definition,
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_oss_db_services,
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_azure_storage_accounts_V2,
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_azure_vm_vulnerability_assessment,
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_azure_kubernetes_services_clusters,
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_azure_app_services,
    data.azurerm_policy_definition.deploy_configure_azure_defender_to_be_enabled_on_SQL_servers,
    data.azurerm_policy_definition.deploy_configure_azure_defender_to_be_enabled_on_azure_SQL_databases,
  ]
}

####################
# Monitoring
####################

# Configures all the Azure Monitor settings, such as Activity Log, Diagnostic Settings, and Log Analytics workspace
module "mod_deploy_diagnostic_monitoring_root_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_monitoring_config"
  initiative_display_name = "Monitoring Governance"
  initiative_description  = "This policy set configures all the Azure Monitor settings, such as Activity Log, Diagnostic Settings for Azure Services, Workspace Retention, Azure Monitor Baseline Alerts for Service Health and DenyAction Delete on Activity Log Settings and Diagnostic Settings."
  initiative_category     = "Monitoring"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_deploy_resource_diagnostic_setting_root_definition["audit_log_analytics_workspace_retention"].definition, # Using a local to call the definition
    module.mod_deploy_resource_diagnostic_setting_root_definition["audit_sub_diagnostic_setting_exist"].definition,      # Using a local to call the definition
    module.mod_deploy_denyaction_root_definition["deny_action_activity_logs"].definition, # DenyAction Delete on Activity Log Settings
    module.mod_deploy_denyaction_root_definition["deny_action_diagnostic_logs"].definition, # DenyAction Delete on Diagnostic Settings
    module.mod_deploy_aa_totaljob_alert_root_definition.definition, # Azure Monitor Baseline Alerts for Service Health
    module.mod_deploy_activitylog_la_del_root_definition.definition, # Azure Monitor Baseline Alerts for Service Health
    module.mod_deploy_activitylog_la_keyregen_root_definition.definition,# Azure Monitor Baseline Alerts for Service Health
    module.mod_deploy_rv_backup_alert_root_definition.definition,# Azure Monitor Baseline Alerts for Service Health
    module.mod_deploy_sa_availability_alert_root_definition.definition,# Azure Monitor Baseline Alerts for Service Health
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_storage_account_blob_services, # Using a data source to call the definition
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_storage_account_file_services,
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_storage_account_queue_services,
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_storage_account_table_services,
    data.azurerm_policy_definition.deploy_diagnostic_settings_should_be_configured_for_azure_network_security_groups,
    data.azurerm_policy_definition.deploy_configure_azure_log_analytics_workspaces_to_disable_public_network_access_for_log_ingestion_and_querying,
  ]
}

####################
# Cost Management
####################

# Configures all the Cost Management settings, such as Budgets
module "mod_deploy_cost_management_config_root_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_cost_management_config"
  initiative_display_name = "Cost Management Governance"
  initiative_description  = "This policy set configures all the Cost Management settings, such as Budgets, and Audit Unused Resources"
  initiative_category     = "Cost Management"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_deploy_cost_management_root_definition["deploy_budget"].definition,
    module.mod_deploy_cost_management_root_definition["audit_disks_unused_resources"].definition,
    module.mod_deploy_cost_management_root_definition["audit_publicIp_addresses_unused_resources"].definition,
    module.mod_deploy_cost_management_root_definition["audit_serverfarms_unused_resources"].definition,
  ]
}

####################
# SQL
####################

# Configures all the SQL settings, such as SQL Security Alert Policies and SQL Auditing Settings
module "mod_deploy_sql_config_root_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_sql_security_config"
  initiative_display_name = "SQL Security Governance"
  initiative_description  = "This policy set configures all the SQL Security settings, such as SQL Security Alert Policies, SQL Transparent Encryption and SQL Auditing Settings"
  initiative_category     = "SQL"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_deploy_sql_root_definition["deploy_sql_security_alert_policies"].definition,
    module.mod_deploy_sql_root_definition["deploy_sql_auditingsettings"].definition,
    module.mod_deploy_sql_root_definition["deploy_sql_min_tls"].definition,
    module.mod_deploy_sql_root_definition["deploy_sql_vulnerability_assessments"].definition,
    data.azurerm_policy_definition.deploy_sql_db_transparent_data_encryption,
  ]
}

##################################
# Identity and Access Management
##################################

# Configures all the SQL settings, such as SQL Security Alert Policies and SQL Auditing Settings
module "mod_deploy_aad_config_root_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_aad_config"
  initiative_display_name = "Identity and Access Management Governance"
  initiative_description  = "This policy set configures all the Identity and Access Management settings, such as Account management, Use private link to access Azure services"
  initiative_category     = "Azure Active Directory"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    //module.mod_audit_user_role_assignments_definition,
    data.azurerm_policy_definition.audit_aad_should_use_private_link_to_access_Azure_services
  ]
}

####################
# Tags
####################

# Configures all the Tag settings, such as Tagging Standards
module "mod_deploy_tags_root_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_tags_config"
  initiative_display_name = "Tagging Standards Governance"
  initiative_description  = "This policy set configures all the Tag settings, such as Inherit Resource Group Tags and Append"
  initiative_category     = "Tags"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_deploy_tags_root_definition["inherit_resource_group_tags_append"].definition,
  ]
}
