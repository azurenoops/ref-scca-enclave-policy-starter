# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy Policy Definitions for Azure Policy in the Platforms Management Group
DESCRIPTION: The following components will be options in this deployment
             * Policy Assignements
AUTHOR/S: jspinella
*/

##################
# Network
##################

# Deny Public IP Addresses on Network 
/* module "mod_mg_deny_public_ip_platforms" {
  source            = "azurenoops/overlays-policy/azurerm//modules/policyDefAssignment/managementGroup"
  version           = "~> 2.0"
  definition        = module.mod_deny_public_ip_platforms.definition
  assignment_scope  = data.azurerm_management_group.platforms.id
  assignment_effect = "Deny"
} */

