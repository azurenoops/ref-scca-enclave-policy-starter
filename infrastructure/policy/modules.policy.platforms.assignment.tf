# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy Policy Definitions for Azure Policy in the Platforms Management Group
DESCRIPTION: The following components will be options in this deployment
             * Policy Assignements
AUTHOR/S: jspinella
*/

##################
# Key Vault
##################

# Deploy Key Vault Policy Assignments
module "mod_platforms_configure_azure_key_vault_initiative_assignment" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version             = "~> 2.0"
  initiative          = module.mod_platforms_configure_azure_key_vault_initiative.initiative
  assignment_scope    = data.azurerm_management_group.platforms.id
  assignment_location = var.default_location

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment
  role_assignment_scope  = data.azurerm_management_group.root.id # using explicit scopes

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]

  # assignment parameters
  assignment_parameters = {
    allowedIPAddresses = var.listOfAllowedIPAddresses, #  Allow only specific IP addresses to access the Key Vault
    minimumDaysBeforeExpiration = var.minimumDaysBeforeExpiration, #  Minimum number of days before a secret or key expires
  }
 
  # 
  assignment_metadata = {
    version  = "1.0.0"
    category = "Key Vault"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}

##################
# Storage Account
##################

# Deploy Storage Account Policy Assignments
module "mod_platforms_configure_azure_storage_account_initiative_assignment" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version             = "~> 2.0"
  initiative          = module.mod_platforms_configure_storage_initiative.initiative
  assignment_scope    = data.azurerm_management_group.platforms.id
  assignment_location = var.default_location

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment
  role_assignment_scope  = data.azurerm_management_group.root.id # using explicit scopes

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]
 
  # 
  assignment_metadata = {
    version  = "1.0.0"
    category = "General"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}
