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
module "mod_root_general_initiative_assignment" {
  source              = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version             = "~> 2.0"
  initiative          = module.mod_deploy_general_config_root_initiative.initiative
  assignment_scope    = data.azurerm_management_group.root.id
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

  assignment_parameters = {
    listOfAllowedLocations = var.listOfAllowedLocations, # Global is used in services such as Azure DNS
    listOfAllowedSKUs      = var.listOfAllowedSKUs,
  }

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

######################
# Defender for Cloud
######################
module "mod_root_configure_defender_initiative_assignment" {
  source           = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version          = "~> 2.0"
  initiative       = module.mod_deploy_defender_root_initiative.initiative
  assignment_scope = data.azurerm_management_group.root.id

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id,
    data.azurerm_role_definition.law_contributor.id,
    data.azurerm_role_definition.security_admin_contributor.id
  ]

  assignment_parameters = {
    workspaceResourceId   = data.azurerm_log_analytics_workspace.anoa_laws.id
    emailSecurityContact  = var.securityContactsEmail
    resourceGroupName     = "${var.org_name}-${var.default_location}-exports-${var.deploy_environment}-rg"
    resourceGroupLocation = var.default_location
  }

  assignment_metadata = {
    version  = "1.0.0"
    category = "Security Center"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}

# Configure Microsoft Defender for Cloud plans.
module "mod_root_deploy_configure_microsoft_defender_for_cloud_plans_initiative_assignment" {
  source           = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version          = "~> 2.0"
  initiative       = data.azurerm_policy_set_definition.deploy_configure_microsoft_defender_for_cloud_plans_initiative
  assignment_scope = data.azurerm_management_group.root.id

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]

  assignment_metadata = {
    version  = "1.0.0"
    category = "Security Center"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}

# Deploy Microsoft Defender for Endpoint agent on applicable images.
module "mod_root_preview_deploy_microsoft_defender_for_endpoint_agent_initiative_assignment" {
  source           = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version          = "~> 2.0"
  initiative       = data.azurerm_policy_set_definition.deploy_microsoft_defender_for_endpoint_agent_initiative
  assignment_scope = data.azurerm_management_group.root.id

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]

  assignment_metadata = {
    version  = "1.0.0"
    category = "Security Center"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}

# Deploy Microsoft Defender for Databases.
module "mod_root_preview_deploy_microsoft_defender_for_databases_initiative_assignment" {
  source           = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version          = "~> 2.0"
  initiative       = data.azurerm_policy_set_definition.deploy_microsoft_defender_for_databases_initiative
  assignment_scope = data.azurerm_management_group.root.id

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]

  assignment_metadata = {
    version  = "1.0.0"
    category = "Security Center"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}

###############################
# Software Defined Networking
###############################

# Audit Public Network Access Initiative.
module "mod_root_audit_public_networks_initiative_assignment" {
  source           = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version          = "~> 2.0"
  initiative       = data.azurerm_policy_set_definition.audit_public_network_access_initiative
  assignment_scope = data.azurerm_management_group.root.id

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]

  assignment_metadata = {
    version  = "1.0.0"
    category = "SDN"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}

#######################
# Guest Configuration
#######################

# Deploy Guest Configuration Policy Assignments
/* module "mod_root_guest_configuration_initiative_assignment" {
  source                 = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version                = "~> 2.0"
  initiative             = module.mod_enforce_azure_compute_sec_benchmark_root_initiative.initiative
  assignment_scope       = data.azurerm_management_group.root.id
  
  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment
  role_assignment_scope  = data.azurerm_management_group.root.id # using explicit scopes

  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]

  assignment_metadata = {
    version  = "1.0.0"
    category = "Guest Configuration"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
} */


##################
# Monitoring
##################
module "mod_root_monitioring_diagnostics_initiative_assignment" {
  source           = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version          = "~> 2.0"
  initiative       = module.mod_deploy_diagnostic_monitoring_root_initiative.initiative
  assignment_scope = data.azurerm_management_group.root.id

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment
  role_assignment_scope  = data.azurerm_management_group.root.id # using explicit scopes

  role_definition_ids = [
    data.azurerm_role_definition.contributor.id,
    data.azurerm_role_definition.monitoring_contributor.id,
    data.azurerm_role_definition.law_contributor.id,
    data.azurerm_role_definition.st_contributor.id
  ]

  # Assignment parameters are done within the policy definition by using the default values. 
  # Overrided at this by using the following example effect command:
  # effect_DeployDiagnosticsApplicationGateway   = "DeployIfNotExists"
  assignment_parameters = {
    profileName      = "setbypolicy",
    logAnalytics     = data.azurerm_log_analytics_workspace.anoa_laws.id,
    storageAccountId = data.azurerm_storage_account.anoa_laws_storage.id,
    workspaceId      = data.azurerm_log_analytics_workspace.anoa_laws.id,
  }

  assignment_metadata = {
    version  = "1.0.0"
    category = "Monitoring"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}

# Deploy Enable Azure Monitor for VMs.
module "mod_root_preview_deploy_azure_monitor_for_vm_initiative_assignment" {
  source           = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version          = "~> 2.0"
  initiative       = data.azurerm_policy_set_definition.deploy_enable_azure_monitor_for_virtual_machines_initiative
  assignment_scope = data.azurerm_management_group.root.id

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.vm_contributor.id
  ]

  # Assignment parameters are done within the policy definition by using the default values. 
  assignment_parameters = {
    logAnalytics_1 = data.azurerm_log_analytics_workspace.anoa_laws.id
  }

  assignment_metadata = {
    version  = "1.0.0"
    category = "Monitoring"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}

# Deploy Enable Azure Monitor for VMSS.
module "mod_root_preview_deploy_azure_monitor_for_vmss_initiative_assignment" {
  source           = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version          = "~> 2.0"
  initiative       = data.azurerm_policy_set_definition.deploy_enable_azure_monitor_for_virtual_machines_scale_sets_initiative
  assignment_scope = data.azurerm_management_group.root.id

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.vm_contributor.id
  ]

  # Assignment parameters are done within the policy definition by using the default values. 
  assignment_parameters = {
    logAnalytics_1 = data.azurerm_log_analytics_workspace.anoa_laws.id
  }

  assignment_metadata = {
    version  = "1.0.0"
    category = "Monitoring"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}

####################
# Cost Management
####################

# Deploy Microsoft Defender for Endpoint agent on applicable images.
module "mod_root_configure_cost_management_initiative_assignment" {
  source           = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version          = "~> 2.0"
  initiative       = module.mod_deploy_cost_management_config_root_initiative.initiative
  assignment_scope = data.azurerm_management_group.root.id

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]

  # Assignment parameters are done within the policy definition by using the default values. 
  assignment_parameters = {
    amount = var.budget_amount
  }

  assignment_metadata = {
    version  = "1.0.0"
    category = "Cost Management"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}

##################
# Azure AD
##################

module "mod_root_audit_aad_use_private_link_access_azure_services_def_assignment" {
  source           = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version          = "~> 2.0"
  initiative       = module.mod_deploy_aad_config_root_initiative.initiative
  assignment_scope = data.azurerm_management_group.root.id

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]

  assignment_metadata = {
    version  = "1.0.0"
    category = "Cost Management"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}

##################
# SQL
##################

# Deploy Configure Advanced Threat Protection to be enabled on Open Sources Databases.
module "mod_root_preview_deploy_atp_for_open_source_dbs_initiative_assignment" {
  source           = "azurenoops/overlays-policy/azurerm//modules/policySetAssignment/managementGroup"
  version          = "~> 2.0"
  initiative       = data.azurerm_policy_set_definition.deploy_configure_advanced_threat_protection_to_be_enabled_on_open_source_dbs_initiative
  assignment_scope = data.azurerm_management_group.root.id

  skip_remediation     = var.skip_remediation
  skip_role_assignment = var.skip_role_assignment

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id,
  ]

  assignment_metadata = {
    version  = "1.0.0"
    category = "Azure AD"
    anoaCloudEnvironments = [
      "AzureCloud",
      "AzureUSGovernment",
    ]
  }
}
