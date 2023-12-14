# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy Policy Exemptions for Azure Policy in the Platforms Management Group
DESCRIPTION: The following components will be options in this deployment
             * Policy Exemptions
AUTHOR/S: jspinella
*/

###################################################
### Platforms Policy Exemptions Configuations   ###
###################################################

# Subscription Scope Resource Exemption
/* module "exemption_rg_platform_public_ip" {
  source               = "azurenoops/overlays-policy/azurerm//modules/policyExemption/resourceGroup"
  version              = "~> 2.0"
  name                 = "Resource Group Platform Public IP Exemption"
  display_name         = "Exempted"
  description          = "Excludes Resource Group from configuring deny public IP policy"
  scope                = "${local.provider_path.rg_resourceId_prefix.hub}${var.hub_resource_group_name}"
  policy_assignment_id = module.mod_mg_deny_public_ip_platforms.id
} */