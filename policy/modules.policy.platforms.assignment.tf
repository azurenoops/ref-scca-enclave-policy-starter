# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy Policy Definitions for Azure Policy in Partner Environments
DESCRIPTION: The following components will be options in this deployment
             * Policy Definitions
AUTHOR/S: jrspinella
*/

##################
# Network
##################

# Deny Public IP Addresses on Network 
module "mod_mg_deny_public_ip_platforms" {
  source            = "azurenoops/overlays-policy/azurerm//modules/policyDefAssignment/managementGroup"
  version           = ">= 1.2.1"
  definition        = module.mod_deny_public_ip_platforms.definition
  assignment_scope  = data.azurerm_management_group.platforms.id
  assignment_effect = "Deny"
}

