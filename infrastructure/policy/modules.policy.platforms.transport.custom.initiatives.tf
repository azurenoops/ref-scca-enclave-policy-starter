
/*
SUMMARY: Module to deploy Policy Initiatives for Azure Policy in the Transport Management Group
DESCRIPTION: The following components will be options in this deployment
             * Policy Initiatives
AUTHOR/S: jspinella
*/

###################################################
### Transport Policy Initiatives Configuations  ###
###################################################

####################
# Monitoring
####################

# Configures all the Azure Monitor settings, such as Activity Log, Diagnostic Settings, and Log Analytics workspace
module "mod_platforms_transport_deploy_azure_monitor_baseline_transport_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_monitoring_config"
  initiative_display_name = "Azure Monitor Baseline Alerts for Service Health for Transport"
  initiative_description  = "This policy set configures all the Azure Monitor Baseline Alerts for Service Health."
  initiative_category     = "Monitoring"
  management_group_id     = data.azurerm_management_group.transport.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_deploy_aa_totaljob_alert_root_definition.definition,       # Azure Monitor Baseline Alerts for Service Health
    module.mod_deploy_activitylog_la_del_root_definition.definition,      # Azure Monitor Baseline Alerts for Service Health
    module.mod_deploy_activitylog_la_keyregen_root_definition.definition, # Azure Monitor Baseline Alerts for Service Health
    module.mod_deploy_rv_backup_alert_root_definition.definition,         # Azure Monitor Baseline Alerts for Service Health
    module.mod_deploy_sa_availability_alert_root_definition.definition,   # Azure Monitor Baseline Alerts for Service Health
  ]
}

####################
# Logging
####################

# Configures all the Azure Logging settings, such as Log Analytics workspace
module "mod_platforms_transport_logging_transport_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_logging_config"
  initiative_display_name = "Logging Governance for Operations"
  initiative_description  = "This policy set configures all the Azure Logging settings and guardrails, such as Log Analytics workspace retention and Law Agent and Custom Workspace"
  initiative_category     = "Monitoring"
  management_group_id     = data.azurerm_management_group.transport.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_transport_deploy_provision_law_agent_custom_workspace_policy_definition.definition,   # Deploy Law Agent and Custom Workspace
    module.mod_transport_audit_log_analytics_workspace_retention_policy_definition.definition,           # Audit Log Analytics Workspace Retention
    data.azurerm_policy_definition.deploy_configure_azure_log_analytics_workspaces_to_disable_public_network_access_for_log_ingestion_and_querying, # Deploy Configure Azure Log Analytics Workspaces to Disable Public Network Access for Log Ingestion and Querying
    data.azurerm_policy_definition.deploy_logging_by_category_group_for_Log_Analytics_workspaces,                                                   # Deploy Logging by Category Group for Log Analytics workspaces
  ]
}

######################
# Azure Network
######################

# Configures all the Azure Network settings, such as Network Security Groups, Azure Firewall, and DDoS Protection
module "mod_platforms_transport_configure_network_configuration_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_network_config"
  initiative_display_name = "Network Governance for Transport"
  initiative_description  = "This policy set configures all the Azure Network settings and guardrails, such as Network Security Groups, Azure Firewall, and DDoS Protection"
  initiative_category     = "Network"
  management_group_id     = data.azurerm_management_group.transport.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_platforms_network_configurations_policy_definition["deny_publicip"].definition,                 # Deny Public IP
    module.mod_platforms_network_configurations_policy_definition["deny_mgmt_ports_from_internet"].definition, # Deny Management Ports from Internet
    module.mod_platforms_network_configurations_policy_definition["deny_bastion_creation"].definition,         # Deny Bastion Creation
    module.mod_platforms_network_configurations_policy_definition["deny_rdp_from_internet"].definition,        # Deny RDP from Internet
    module.mod_platforms_network_configurations_policy_definition["require_nsg_on_vnet"].definition,           # Require NSG on VNET
    data.azurerm_policy_definition.audit_internet_traffic_should_be_routed_via_deployed_azure_firewall,
    data.azurerm_policy_definition.audit_subscription_should_configure_the_Azure_Firewall_Premium_to_provide_additional_layer_of_protection,
    data.azurerm_policy_definition.deploy_configure_virtual_network_to_enable_traffic_analytics,
    data.azurerm_policy_definition.deploy_configure_network_security_groups_to_enable_traffic_analytics,
    data.azurerm_policy_definition.audit_network_watcher_flow_logs_should_have_traffic_analytics_enabled,
    data.azurerm_policy_definition.audit_flow_logs_should_be_configured_for_every_network_security_group,
    data.azurerm_policy_definition.deploy_azure_DDoS_protection_standard_should_be_enabled,
    data.azurerm_policy_definition.deny_network_interfaces_should_not_have_public_IPs,
  ]
}

######################
# Virtual Machines
######################

# Configures all the Virtual Machine settings, such as VM Extensions, VM Diagnostics, and VM Encryption
module "mod_platforms_transport_configure_virtual_machine_configuration_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_virtual_machine_config"
  initiative_display_name = "Virtual Machine Governance for DevSecOps"
  initiative_description  = "This policy set configures all the Virtual Machine settings and guardrails, such as VM Extensions, VM Diagnostics, and VM Encryption"
  initiative_category     = "Virtual Machines"
  management_group_id     = data.azurerm_management_group.transport.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    data.azurerm_policy_definition.audit_virtual_machines_should_be_connected_to_a_specified_workspace,
    data.azurerm_policy_definition.audit_virtual_machines_should_have_Azure_Monitor_Agent_installed,
    data.azurerm_policy_definition.audit_virtual_machines_and_virtual_machine_scale_sets_should_have_encryption_at_host_enabled,
  ]
}
