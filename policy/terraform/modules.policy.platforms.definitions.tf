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

#Enforce recommended guardrails for Azure Key Vault
/* module "mod_key_vault_guardrails_platforms" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version             = "~> 2.0"
  policy_def_name     = "key_vault_guardrails"
  display_name        = "Platforms Key Vault Guardrails"
  policy_category     = "Key Vault"
  management_group_id = data.azurerm_management_group.platforms.id
} */

##################
# Network
##################

# Deny Public IP Addresses on Network 
module "mod_deny_public_ip_platforms" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version             = "~> 2.0"
  policy_def_name     = "deny_publicip"
  display_name        = "Platforms Network should not have public IPs"
  policy_category     = "Network"
  management_group_id = data.azurerm_management_group.platforms.id
}

#Virtual networks should be protected by Azure DDoS Network Protection
module "mod_ddos_protection_platforms" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policyDefinition"
  version             = "~> 2.0"
  policy_def_name     = "deploy_ddosprotection"
  display_name        = "Platforms Network should be protected by Azure DDoS Network Protection"
  policy_category     = "Network"
  management_group_id = data.azurerm_management_group.platforms.id
}

resource "time_sleep" "after_azurerm_policy_definition" {
  depends_on = [
    module.mod_deny_public_ip_platforms, 
    //module.mod_key_vault_guardrails_platforms,   
  ]

  triggers = {
    "azurerm_policy_definition_noops" = jsonencode(keys(module.mod_deny_public_ip_platforms))    
  }

  create_duration  = local.create_duration_delay["after_azurerm_policy_definition"]
  destroy_duration = local.destroy_duration_delay["after_azurerm_policy_definition"]
}
