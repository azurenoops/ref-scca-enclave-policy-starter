
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
module "mod_configure_general_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_general_config"
  initiative_display_name = "Deploy General configuration"
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

####################
# Monitoring
####################

# Configures all the Azure Monitor settings, such as Activity Log, Diagnostic Settings, and Log Analytics workspace
module "mod_configure_diagnostic_monitoring_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_monitoring_config"
  initiative_display_name = "Deploy Diagnostic Settings to Azure Services"
  initiative_description  = "This policy set deploys the configurations of application Azure resources to forward diagnostic logs and metrics to an Azure Log Analytics workspace. See the list of policies of the services that are included."
  initiative_category     = "Monitoring"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.deploy_resource_diagnostic_setting["audit_log_analytics_workspace_retention"].definition, # Using a local to call the definition
    module.deploy_resource_diagnostic_setting["deploy_aci_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_acr_diagnostic_settings"].definition,
    module.deploy_resource_diagnostic_setting["deploy_api_mgmt_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_application_gateway_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_bastion_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_expressroute_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_firewall_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_frontdoor_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_function_diagnostics_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_loadbalancer_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_logAnalytics_diagnostics_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_network_interface_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_public_ip_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_redis_diagnostics_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_storage_account_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_sql_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_subscription_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_vnet_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_virtual_machine_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_vmss_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_vnet_gateway_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_webapp_diagnostic_setting"].definition,
    data.azurerm_policy_definition.deploy_diagnostic_settings_should_be_configured_for_azure_storage_account, # Using a data source to call the definition
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_storage_account_blob_services,
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_storage_account_file_services,
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_storage_account_queue_services,
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_storage_account_table_services,
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_AKS,
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_batch,
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_data_lake_store,
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_key_vault,
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_logic_apps,
    data.azurerm_policy_definition.deploy_monitoring_should_be_configured_for_azure_network_security_groups,
  ]
}


#DenyAction-DeleteProtection
module "mod_configure_general_initiative_deny_action_delete_protection" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deny_action_delete_protection"
  initiative_display_name = "DenyAction Delete - Activity Log Settings and Diagnostic Settings"
  initiative_description  = "This policy set enforces DenyAction - Delete on Activity Log Settings and Diagnostic Settings."
  initiative_category     = "Monitoring"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    data.azurerm_policy_definition.deny_action_delete_protection,
  ]
}

######################
# Defender for Cloud
######################

# Configures all the MDFC settings, such as Microsoft Defender for Cloud 
# per individual service, security contacts, and export from MDFC to Log Analytics workspace
module "mod_configure_defender_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_MDFC_config"
  initiative_display_name = "Deploy Microsoft Defender for Cloud configuration"
  initiative_description  = "This policy set configures all the MDFC settings, such as Microsoft Defender for Cloud per individual service, security contacts, and export from MDFC to Log Analytics workspace"
  initiative_category     = "Security Center"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_oss_db_services,
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_azure_sql_servers,
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_azure_storage_accounts_V2,
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_azure_vm_vulnerability_assessment,
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_sql_server_virtual_machines,
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_azure_kubernetes_services_clusters,
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_azure_virtual_machine_scale_sets,
    data.azurerm_policy_definition.deploy_mdfc_should_be_configured_for_azure_app_services,
  ]
}

####################
# Cost Management
####################

# Configures all the Cost Management settings, such as Budgets
module "mod_configure_cost_management_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_cost_management_config"
  initiative_display_name = "Deploy Cost Management configuration"
  initiative_description  = "Configures all the Cost Management settings, such as Budgets"
  initiative_category     = "Cost Management"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.deploy_cost_management_policy_definition.definition,
  ]
}

##################
# Azure AD
##################

# Configures all the Azure AD settings, such as Azure AD Identity Protection
module "mod_configure_azure_ad_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_azure_ad_config"
  initiative_display_name = "Deploy Azure AD service catalog configuration"
  initiative_description  = "Configures all the Azure AD settings, such as Azure AD Identity Protection, Azure AD Conditional Access, and Azure AD Privileged Identity Management"
  initiative_category     = "AAD"
  management_group_id     = data.azurerm_management_group.root.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    data.azurerm_policy_definition.deploy_azure_ad_identity_protection_should_be_enabled,
  ]
}


