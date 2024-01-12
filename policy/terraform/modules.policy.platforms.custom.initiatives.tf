
/*
SUMMARY: Module to deploy Policy Initiatives for Azure Policy in the Platforms Management Group
DESCRIPTION: The following components will be options in this deployment
             * Policy Initiatives
AUTHOR/S: jspinella
*/

###################################################
### Platforms Policy Initiatives Configuations  ###
###################################################

####################
# Azure Key Vault
####################

# Configures all the Azure Key Vault settings and gaurdrails, such as Azure Key Vault Auditing, Purge Protection, and Soft Delete
module "mod_platforms_configure_azure_key_vault_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0" 
  initiative_name         = "deploy_azure_key_vault_config"
  initiative_display_name = "Key Vault Governance"
  initiative_description  = "This policy set configures all the Azure Key Vault settings and gaurdrails, such as Azure Key Vault Auditing, Purge Protection, and Soft Delete"
  initiative_category     = "Key Vault"
  management_group_id     = data.azurerm_management_group.platforms.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    data.azurerm_policy_definition.deploy_key_vaults_should_be_configured_to_use_soft_delete,
    data.azurerm_policy_definition.deploy_key_vaults_should_be_configured_to_use_purge_protection,
    data.azurerm_policy_definition.deploy_key_vaults_secrets_should_have_an_expiration_date,
    data.azurerm_policy_definition.deploy_key_vaults_keys_should_have_an_expiration_date,
    data.azurerm_policy_definition.deploy_key_vaults_should_have_firewall_enabled,
    data.azurerm_policy_definition.deploy_certificates_should_have_the_specified_lifetime_action_triggers,
    data.azurerm_policy_definition.deploy_keys_should_have_more_than_the_specified_number_of_days_before_expiration,
    data.azurerm_policy_definition.deploy_secrets_should_have_more_than_the_specified_number_of_days_before_expiration,
  ]
}

##################
# Storage
##################

# Configures all the Storage settings, such as Storage Accounts
/* module "mod_platforms_configure_storage_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_storage_config"
  initiative_display_name = "Storage Governance"
  initiative_description  = "Configures all the Storage settings, such as Storage Accounts with encryption and HTTPS traffic only"
  initiative_category     = "Storage"
  management_group_id     = data.azurerm_management_group.platforms.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    data.azurerm_policy_definition.deploy_storage_account_should_be_configured_to_use_private_link,
  ]
} */

######################
# Azure Network
######################

# Configures all the Azure Network settings, such as Network Security Groups, Azure Firewall, and DDoS Protection
/* module "mod_platforms_configure_network_configuration_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_network_config"
  initiative_display_name = "Network Governance"
  initiative_description  = "This policy set configures all the Azure Network settings, such as Network Security Groups, Azure Firewall, and DDoS Protection"
  initiative_category     = "Azure Network"
  management_group_id     = data.azurerm_management_group.platforms.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    data.azurerm_policy_definition.deny_not_allowed_resource_types_public_ips,
    data.azurerm_policy_definition.modify_virtual_networks_should_be_protected_by_azure_ddos_protection_standard,
    data.azurerm_policy_definition.deploy_configure_nsg_to_use_specific_retention_policy_for_traffic_analytics,
    data.azurerm_policy_definition.deploy_internet_traffic_should_be_routed_via_deployed_azure_firewall,
    data.azurerm_policy_definition.audit_subscription_should_configure_the_Azure_Firewall_Premium_to_provide_additional_layer_of_protection,
    data.azurerm_policy_definition.deploy_configure_network_security_groups_to_enable_traffic_analytics,
    data.azurerm_policy_definition.audit_network_watcher_flow_logs_should_have_traffic_analytics_enabled,
    data.azurerm_policy_definition.audit_flow_logs_should_be_configured_for_every_network_security_group,
    data.azurerm_policy_definition.audit_flow_logs_should_be_configured_for_every_virtual_network,
    data.azurerm_policy_definition.deploy_azure_DDoS_protection_standard_should_be_enabled,
  ]
} */