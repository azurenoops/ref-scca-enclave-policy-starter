
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
    module.mod_deploy_general_root_definition["audit_locks_on_networking"].definition,
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
  initiative_description  = "This policy set configures the MDFC settings, such as Security contacts, and export from MDFC to Log Analytics workspace"
  initiative_category     = "Security Center"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_deploy_defender_root_definition["deploy_asc_security_contacts"].definition,
    data.azurerm_policy_definition.deploy_export_to_law_for_mdfc_data,                                   # Deploy export to Log Analytics workspace for Microsoft Defender for Cloud data  
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
  initiative_description  = "This policy set deploys the configurations of application Azure resources to forward diagnostic logs and metrics to an Azure Log Analytics workspace. See the list of policies of the services that are included."
  initiative_category     = "Monitoring"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_deploy_resource_diagnostic_setting_root_definition["deploy_subscription_diagnostic_setting"].definition,      #  Using a local to call the definition
    module.mod_deploy_resource_diagnostic_setting_root_definition["deploy_virtual_machine_diagnostic_setting"].definition,   # Using a local to call the definition
    module.mod_deploy_resource_diagnostic_setting_root_definition["deploy_public_ip_diagnostic_setting"].definition,         # Using a local to call the definition
    module.mod_deploy_resource_diagnostic_setting_root_definition["deploy_network_interface_diagnostic_setting"].definition, # Using a local to call the definition
    module.mod_deploy_resource_diagnostic_setting_root_definition["deploy_logAnalytics_diagnostics_setting"].definition,     # Using a local to call the definition
    module.mod_deploy_resource_diagnostic_setting_root_definition["deploy_firewall_diagnostic_setting"].definition,          # Using a local to call the definition
    module.mod_deploy_resource_diagnostic_setting_root_definition["deploy_bastion_diagnostic_setting"].definition,           # Using a local to call the definition
    module.mod_deploy_resource_diagnostic_setting_root_definition["deploy_activitylog_keyvault_del"].definition,             # Using a local to call the definition
    module.mod_deploy_resource_diagnostic_setting_root_definition["deploy_vnet_diagnostic_setting"].definition,              # Using a local to call the definition
    module.mod_deploy_resource_diagnostic_setting_root_definition["deploy_sqlmi_diagnostic_setting"].definition,             # Using a local to call the definition
    module.mod_deploy_resource_diagnostic_setting_root_definition["deploy_webserverfarm_diagnostic_setting"].definition,     # Using a local to call the definition
    module.mod_deploy_resource_diagnostic_setting_root_definition["deploy_webapp_diagnostic_setting"].definition,            # Using a local to call the definition
    module.mod_deploy_denyaction_root_definition["deny_action_activity_logs"].definition,                                    # DenyAction Delete on Activity Log Settings
    module.mod_deploy_denyaction_root_definition["deny_action_diagnostic_logs"].definition,                                  # DenyAction Delete on Diagnostic Settings
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
    data.azurerm_policy_definition.deploy_threat_detection_on_SQL_servers,
    data.azurerm_policy_definition.deploy_advanced_data_security_on_SQL_servers,
    data.azurerm_policy_definition.audit_aad_administrator_should_be_provisioned_for_SQL_servers,
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
    data.azurerm_policy_definition.audit_aad_should_use_private_link_to_access_Azure_services,
    data.azurerm_policy_definition.audit_A_maximum_3_owners_should_be_designated_for_your_subscription,
    data.azurerm_policy_definition.audit_blocked_accounts_with_owner_permissions_on_Azure_resources_should_be_removed,
    data.azurerm_policy_definition.audit_usage_of_custom_RBAC_roles,
    data.azurerm_policy_definition.audit_accounts_with_owner_permissions_on_azure_resources_should_be_MFA_enabled,
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
