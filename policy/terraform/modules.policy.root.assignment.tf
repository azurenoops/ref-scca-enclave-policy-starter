# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy Policy Assignments for Azure Policy in the Root Management Group
DESCRIPTION: The following components will be options in this deployment
             * Policy Assignments
AUTHOR/S: jspinella
*/

#######################################
### Policy Assignment Configuations ###
#######################################

##################
# General
##################
 
# Deploy General Policy Assignments
module "root_mg_general_initiative_assignment" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version                = "~> 2.0"
  initiative             = module.mod_configure_general_initiative.initiative
  assignment_name        = "Deploy General configuration"
  assignment_scope       = data.azurerm_management_group.root.id
  assignment_description = "This policy set deploys the configurations for General settings, such as Allowed Virtual Machine Sizes, Allowed Regions, and Allowed Resource Types. See the list of policies of the services that are included."
  assignment_location    = var.default_location

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment
  role_assignment_scope  = data.azurerm_management_group.root.id # using explicit scopes

  identity_ids = [
    data.azurerm_user_assigned_identity.policy_rem.id
  ]

  assignment_parameters = {
    profileName  = "setbypolicy"
  }
}

##################
# Monitoring
##################
module "root_mg_monitioring_diagnostics_initiative_assignment" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version                = "~> 2.0"
  initiative             = module.mod_configure_diagnostic_monitoring_initiative.initiative
  assignment_name        = "Deploy Diagnostic Settings to Azure Services"
  assignment_scope       = data.azurerm_management_group.root.id
  assignment_description = "This policy set deploys the configurations of application Azure resources to forward diagnostic logs and metrics to an Azure Log Analytics workspace. See the list of policies of the services that are included."
  assignment_location    = var.default_location

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment
  role_assignment_scope  = data.azurerm_management_group.root.id # using explicit scopes

  identity_ids = [
    data.azurerm_user_assigned_identity.policy_rem.id
  ]

  assignment_parameters = {
    logAnalytics = data.azurerm_log_analytics_workspace.anoa_laws.id
    profileName  = "setbypolicy"
  }
}

# Deploy Enable Azure Monitor for VMs.
module "mod_preview_deploy_azure_monitor_for_vm_initiative_assignment" {
  source               = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version              = "~> 2.0"
  initiative           = data.azurerm_policy_set_definition.enable_azure_monitor_for_vm_with_azure_monitoring_agent_initiative
  assignment_name      = "Enable Azure Monitor for VMs with Azure Monitoring Agent(AMA)"
  assignment_scope     = data.azurerm_management_group.root.id
  skip_remediation     = var.skip_remediation
  skip_role_assignment = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.vm_contributor.id
  ]
}

# Deploy Enable Azure Monitor for VMSS.
module "mod_preview_deploy_azure_monitor_for_vm_initiative_assignment" {
  source               = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version              = "~> 2.0"
  initiative           = data.azurerm_policy_set_definition.enable_azure_monitor_for_vmss_with_azure_monitoring_agent_initiative
  assignment_name      = "Enable Azure Monitor for VMSS with Azure Monitoring Agent(AMA)"
  assignment_scope     = data.azurerm_management_group.root.id
  skip_remediation     = var.skip_remediation
  skip_role_assignment = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.vm_contributor.id
  ]
}

######################
# Defender for Cloud
######################
module "org_mg_configure_defender_initiative_assignment" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version                = "~> 2.0"
  initiative             = module.mod_configure_defender_initiative.initiative
  assignment_scope       = data.azurerm_management_group.root.id
  assignment_description = "Deploys and configures Defender settings and defines exports"
  assignment_effect      = "DeployIfNotExists"
  assignment_location    = var.default_location

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment
  role_assignment_scope  = data.azurerm_management_group.root.id # using explicit scopes

  assignment_parameters = {
    workspaceId           = data.azurerm_log_analytics_workspace.anoa_laws.id
    //securityContactsEmail = var.securityContactsEmail
    //securityContactsPhone = var.securityContactsPhone
  }

  identity_ids = [
    data.azurerm_user_assigned_identity.policy_rem.id
  ]

  # optional non-compliance messages. Key/Value pairs map as policy_definition_reference_id = 'content'
  non_compliance_messages = {
    null                    = "The Default non-compliance message for all member definitions"
    AutoEnrollSubscriptions = "The non-compliance message for the auto_enroll_subscriptions definition"
  }
}

# Deploy Microsoft Defender for Endpoint agent on applicable images.
module "mod_preview_deploy_microsoft_defender_for_endpoint_agent_initiative_assignment" {
  source               = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version              = "~> 2.0"
  initiative           = data.azurerm_policy_set_definition.preview_deploy_microsoft_defender_for_endpoint_agent_initiative
  assignment_name      = "preview_deploy_microsoft_defender_for_endpoint_agent"
  assignment_scope     = data.azurerm_management_group.root.id
  skip_remediation     = var.skip_remediation
  skip_role_assignment = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.vm_contributor.id
  ]
}

# Configure Advanced Threat Protection to be enabled on open-source relational databases.
module "mod_deploy_configure_advanced_threat_protection_to_be_enabled_on_open_source_relational_databases_initiative_assignment" {
  source               = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version              = "~> 2.0"
  initiative           = data.azurerm_policy_set_definition.deploy_configure_advanced_threat_protection_to_be_enabled_on_open_source_relational_databases_initiative
  assignment_name      = "Configure Advanced Threat Protection to be enabled on open-source relational databases"
  assignment_scope     = data.azurerm_management_group.root.id
  skip_remediation     = var.skip_remediation
  skip_role_assignment = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.vm_contributor.id
  ]
}

####################
# Cost Management
####################

######################
# Azure Network
######################

##################
# Storage
##################
/* module "mod_mg_storage_enforce_https" {
  source            = "azurenoops/overlays-policy/azurerm//modules/policyDefAssignment/managementGroup"
  version           = "~> 2.0"
  definition        = module.mod_storage_enforce_https.definition
  assignment_scope  = data.azurerm_management_group.root.id
  assignment_effect = "Deny"
}

module "mod_mg_storage_enforce_minimum_tls1_2" {
  source            = "azurenoops/overlays-policy/azurerm//modules/policyDefAssignment/managementGroup"
  version           = "~> 2.0"
  definition        = module.mod_storage_enforce_minimum_tls1_2.definition
  assignment_scope  = data.azurerm_management_group.root.id
  assignment_effect = "Deny"
} */

##################
# Azure AD
##################

##################
# Azure SQL
##################

##################
# Azure Key Vault
##################

/* resource "time_sleep" "after_azurerm_policy_assignment" {
  depends_on = [
    time_sleep.after_azurerm_policy_definition,
    module.mod_mg_deny_public_ip_platforms,
    module.mod_mg_deny_public_ip_workloads_internal,
    module.mod_mg_deny_public_ip_workloads_partners,
    module.mod_mg_storage_enforce_https,
    module.mod_mg_storage_enforce_minimum_tls1_2
  ]

  triggers = {
    "azurerm_management_group_policy_assignment_noops" = jsonencode(keys(module.mod_mg_deny_public_ip_platforms)),
    "azurerm_management_group_policy_assignment_noops" = jsonencode(keys(module.mod_mg_deny_public_ip_workloads_internal)),
    "azurerm_management_group_policy_assignment_noops" = jsonencode(keys(module.mod_mg_deny_public_ip_workloads_partners)),
    "azurerm_management_group_policy_assignment_noops" = jsonencode(keys(module.mod_mg_storage_enforce_https)),
    "azurerm_management_group_policy_assignment_noops" = jsonencode(keys(module.mod_mg_storage_enforce_minimum_tls1_2))
  }

  create_duration  = local.create_duration_delay["after_azurerm_policy_assignment"]
  destroy_duration = local.destroy_duration_delay["after_azurerm_policy_assignment"]
} */
