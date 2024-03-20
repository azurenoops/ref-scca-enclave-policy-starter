
/*
SUMMARY: Module to deploy Policy Initiatives for Azure Policy in the Security Management Group
DESCRIPTION: The following components will be options in this deployment
             * Policy Initiatives
AUTHOR/S: jspinella
*/

###################################################
### Security Policy Initiatives Configuations  ###
###################################################

####################
# Monitoring
####################

# Configures all the Azure Monitor settings, such as Activity Log, Diagnostic Settings, and Log Analytics workspace
module "mod_platforms_security_deploy_azure_monitor_baseline_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_monitoring_config"
  initiative_display_name = "Azure Monitor Baseline Alerts for Service Health for Security"
  initiative_description  = "This policy set configures all the Azure Monitor Baseline Alerts for Service Health."
  initiative_category     = "Monitoring"
  management_group_id     = data.azurerm_management_group.security.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_deploy_aa_totaljob_alert_root_definition.definition, # Azure Monitor Baseline Alerts for Service Health
    module.mod_deploy_activitylog_la_del_root_definition.definition, # Azure Monitor Baseline Alerts for Service Health
    module.mod_deploy_activitylog_la_keyregen_root_definition.definition,# Azure Monitor Baseline Alerts for Service Health
    module.mod_deploy_rv_backup_alert_root_definition.definition,# Azure Monitor Baseline Alerts for Service Health
    module.mod_deploy_sa_availability_alert_root_definition.definition,# Azure Monitor Baseline Alerts for Service Health
  ]
}

######################
# Azure Network
######################

# Configures all the Azure Network settings, such as Network Security Groups, Azure Firewall, and DDoS Protection
module "mod_platforms_security_configure_network_configuration_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = "~> 2.0"
  initiative_name         = "deploy_network_config"
  initiative_display_name = "Network Governance for Security"
  initiative_description  = "This policy set configures all the Azure Network settings and guardrails, such as Network Security Groups, Azure Firewall, and DDoS Protection"
  initiative_category     = "Network"
  management_group_id     = data.azurerm_management_group.security.id
  merge_effects           = false

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_platforms_network_configurations_policy_definition["deny_publicip"].definition, # Deny Public IP
    module.mod_platforms_network_configurations_policy_definition["deny_mgmt_ports_from_internet"].definition, # Deny Management Ports from Internet
    module.mod_platforms_network_configurations_policy_definition["deny_bastion_creation"].definition, # Deny Bastion Creation
    module.mod_platforms_network_configurations_policy_definition["deny_rdp_from_internet"].definition, # Deny RDP from Internet
    module.mod_platforms_network_configurations_policy_definition["require_nsg_on_vnet"].definition, # Require NSG on VNET
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