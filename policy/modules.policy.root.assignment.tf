# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy Policy Assignments for Azure Policy in Partner Environments
DESCRIPTION: The following components will be options in this deployment
             * Policy Assignments
AUTHOR/S: jrspinella
*/

#######################################
### Policy Assignment Configurations ###
#######################################

###########################
# Network: Private Dns  ###
###########################
/* module "org_mg_private_endpoints_initiative" {
  source           = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version          = ">= 1.1.0"
  initiative       = "./policy/custom/policyset/network/deploy_private_dns_zones.json"
  assignment_scope = data.azurerm_management_group.root.id
  skip_remediation = var.skip_remediation

  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]

  assignment_parameters = {
  }
} */

/* resource "time_sleep" "after_azurerm_policy_set_definition" {
  depends_on = [
    time_sleep.after_azurerm_policy_definition,
    module.platform_diagnostics_initiative,
  ]

  triggers = {
    "azurerm_policy_set_definition_noops" = jsonencode(keys(module.platform_diagnostics_initiative))
  }

  create_duration  = local.create_duration_delay["after_azurerm_policy_set_definition"]
  destroy_duration = local.destroy_duration_delay["after_azurerm_policy_set_definition"]
}
 */

##################
# Monitoring
##################
module "org_mg_platform_diagnostics_initiative" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version                = ">= 1.2.1"
  initiative             = module.mod_platform_diagnostics_initiative.initiative
  assignment_scope       = data.azurerm_management_group.root.id
  assignment_description = "Deploys and configures Diagnostics settings to Log Analytics Workspace and Storage Account"
  assignment_location    = "eastus"

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment
  role_assignment_scope  = data.azurerm_management_group.root.id # using explicit scopes

  identity_ids = [
    data.azurerm_user_assigned_identity.policy_rem.id
  ]

  assignment_parameters = {
    workspaceId                                        = data.azurerm_log_analytics_workspace.anoa_laws.id
    storageAccountId                                   = data.azurerm_storage_account.logging_storage_account.id
    eventHubName                                       = ""
    eventHubAuthorizationRuleId                        = ""
    metricsEnabled                                     = "True"
    logsEnabled                                        = "True"
    effect_DeployApplicationGatewayDiagnosticSetting   = "DeployIfNotExists"
    effect_DeployFirewallDiagnosticSetting             = "DeployIfNotExists"
    effect_DeployKeyvaultDiagnosticSetting             = "AuditIfNotExists"
    effect_DeployNetworkInterfaceDiagnosticSetting     = "AuditIfNotExists"
    effect_DeployNetworkSecurityGroupDiagnosticSetting = "AuditIfNotExists"
    effect_DeployPublicIpDiagnosticSetting             = "AuditIfNotExists"
    effect_DeployStorageAccountDiagnosticSetting       = "DeployIfNotExists"
    effect_DeploySubscriptionDiagnosticSetting         = "DeployIfNotExists"
    effect_DeployVnetDiagnosticSetting                 = "AuditIfNotExists"
    effect_DeployApiMgmtDiagnosticSetting              = "DeployIfNotExists"
    effect_DeployBastionDiagnosticSetting              = "DeployIfNotExists"
  }
}


##################
# Security Center
##################
module "org_mg_configure_asc_initiative" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version                = ">= 1.2.1"
  initiative             = module.mod_configure_asc_initiative.initiative
  assignment_scope       = data.azurerm_management_group.root.id
  assignment_description = "Deploys and configures Defender settings and defines exports"
  assignment_effect      = "DeployIfNotExists"
  assignment_location    = "eastus"

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment
  role_assignment_scope  = data.azurerm_management_group.root.id # using explicit scopes

  assignment_parameters = {
    workspaceId           = data.azurerm_log_analytics_workspace.anoa_laws.id
    eventHubDetails       = ""
    securityContactsEmail = var.securityContactsEmail
    securityContactsPhone = ""
  }

  identity_ids = [
    data.azurerm_user_assigned_identity.policy_rem.id
  ]

  # optional non-compliance messages. Key/Value pairs map as policy_definition_reference_id = 'content'
  non_compliance_messages = {
    null                    = "The Default non-compliance message for all member definitions"
    AutoEnrollSubscriptions = "The non-compliance message for the auto_enroll_subscriptions definition"
  }

  # optional overrides (preview)
  overrides = [
    {
      effect = "AuditIfNotExists"
      selectors = {
        in = ["ExportAscAlertsAndRecommendationsToEventhub", "ExportAscAlertsAndRecommendationsToLogAnalytics"]
      }
    }
  ]
}

##################
# Storage
##################
module "mod_mg_storage_enforce_https" {
  source            = "azurenoops/overlays-policy/azurerm//modules/policyDefAssignment/managementGroup"
  version           = ">= 1.2.1"
  definition        = module.mod_storage_enforce_https.definition
  assignment_scope  = data.azurerm_management_group.root.id
  assignment_effect = "Deny"
}

module "mod_mg_storage_enforce_minimum_tls1_2" {
  source            = "azurenoops/overlays-policy/azurerm//modules/policyDefAssignment/managementGroup"
  version           = ">= 1.2.1"
  definition        = module.mod_storage_enforce_minimum_tls1_2.definition
  assignment_scope  = data.azurerm_management_group.root.id
  assignment_effect = "Deny"
}

resource "time_sleep" "after_azurerm_policy_assignment" {
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
}
