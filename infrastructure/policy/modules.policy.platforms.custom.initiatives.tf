
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
  initiative_description  = "This policy set configures all the Azure Key Vault settings and guardrails, such as Azure Key Vault Auditing, Purge Protection, and Soft Delete"
  initiative_category     = "Key Vault"
  management_group_id     = data.azurerm_management_group.platforms.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    data.azurerm_policy_definition.audit_key_vaults_should_be_configured_to_use_soft_delete,
    data.azurerm_policy_definition.audit_key_vaults_should_be_configured_to_use_purge_protection,
    data.azurerm_policy_definition.deploy_key_vaults_secrets_should_have_an_expiration_date,
    data.azurerm_policy_definition.deploy_key_vaults_keys_should_have_an_expiration_date,
    data.azurerm_policy_definition.audit_key_vaults_should_have_firewall_enabled,
    data.azurerm_policy_definition.deploy_keys_should_have_more_than_the_specified_number_of_days_before_expiration,
    data.azurerm_policy_definition.deploy_secrets_should_have_more_than_the_specified_number_of_days_before_expiration,
    data.azurerm_policy_definition.audit_vaults_should_use_private_link,
  ]
}

##################
# Storage
##################

# Configures all the Storage settings, such as Storage Accounts
module "mod_platforms_configure_storage_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_storage_account_config"
  initiative_display_name = "Storage Governance"
  initiative_description  = "This policy set configures all the Azure Storage settings and guardrails, such as Storage Accounts with encryption and HTTPS traffic only"
  initiative_category     = "Storage"
  management_group_id     = data.azurerm_management_group.platforms.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    data.azurerm_policy_definition.audit_storage_account_should_be_configured_to_use_private_link,
    data.azurerm_policy_definition.deploy_storage_accounts_should_have_min_tls_version,
    data.azurerm_policy_definition.audit_storage_accounts_should_allow_access_from_trusted_Microsoft_services,
    data.azurerm_policy_definition.audit_storage_accounts_should_be_configured_to_use_encryption,
    data.azurerm_policy_definition.deploy_storage_accounts_should_prevent_cross_tenant_object_replication,
    data.azurerm_policy_definition.modify_configure_secure_transfer_of_data_on_a_storage_account,
    data.azurerm_policy_definition.audit_geo_redundant_storage_should_be_enabled_for_storage_accounts,
  ]
}