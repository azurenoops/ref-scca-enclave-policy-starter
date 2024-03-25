# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy Policy Exemptions for Azure Policy in the Transport Management Group
DESCRIPTION: The following components will be options in this deployment
             * Policy Exemptions
AUTHOR/S: jspinella
*/

##################
# Network
##################

# create exemptions by calling them explicitly from a local (as above)
/* module "mod_exemption_transport_deny_public_ip" {
  source               = "azurenoops/overlays-policy/azurerm//modules/policyExemption/managementGroup"
  version              = "~> 2.0"
  name                 = "Deny Public IP Exemption"
  display_name         = "Exempted due to Hub Placement"
  description          = "Allows Public IPs for Hub Subscription"
  scope                = data.azurerm_management_group.transport.id
  policy_assignment_id = module.mod_platforms_transport_configure_network_configuration_initiative_assignment.id
  exemption_category   = "Waiver"
  expires_on           = "2025-05-25"

  # use member_definition_names for simplicity when policy_definition_reference_ids are unknown
  member_definition_names = [
    "deny_publicip"
  ]
}  */

