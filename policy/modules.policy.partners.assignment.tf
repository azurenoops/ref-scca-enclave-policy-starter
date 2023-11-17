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

module "mod_mg_deny_public_ip_workloads_partners" {
  source            = "azurenoops/overlays-policy/azurerm//modules/policyDefAssignment/managementGroup"
  version           = ">= 1.2.1"
  definition        = module.mod_deny_public_ip_workloads_partners.definition
  assignment_scope  = data.azurerm_management_group.partners.id
  assignment_effect = "Deny"

  # specify a list of role definitions or omit to use those defined in the policies
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]
}

