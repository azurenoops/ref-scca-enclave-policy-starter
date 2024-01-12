/*
SUMMARY: Module to deploy builtin Policy Initiatives for Azure Policy in the Root Management Group
DESCRIPTION: The following components will be options in this deployment
             * Policy Initiatives
AUTHOR/S: jspinella
*/

#######################
# Built-In Initiatives
#######################

##################
# General
##################

data "azurerm_policy_set_definition" "preview_deploy_microsoft_defender_for_endpoint_agent_initiative" {
  name = "e20d08c5-6d64-656d-6465-ce9e37fd0ebc" #"[Preview]: Deploy Microsoft Defender for Endpoint agent"
}

data "azurerm_policy_set_definition" "enable_azure_monitor_for_vm_with_azure_monitoring_agent_initiative" {
  name = "924bfe3a-762f-40e7-86dd-5c8b95eb09e6" #"Enable Azure Monitor for VMs with Azure Monitoring Agent(AMA)"
}

data "azurerm_policy_set_definition" "enable_azure_monitor_for_vmss_with_azure_monitoring_agent_initiative" {
  name = "f5bf694c-cca7-4033-b883-3a23327d5485" #"Enable Azure Monitor for VMSS with Azure Monitoring Agent(AMA)"
}


##################
# Security Center
##################

data "azurerm_policy_set_definition" "deploy_microsoft_cloud_security_benchmark_initiative" {
  name = "1f3afdf9-d0c9-4c3d-847f-89da613e70a8" #"Microsoft cloud security benchmark"
}

data "azurerm_policy_set_definition" "deploy_configure_advanced_threat_protection_to_be_enabled_on_open_source_dbs_initiative" {
  name = "e77fc0b3-f7e9-4c58-bc13-cb753ed8e46e" #"Configure Advanced Threat Protection to be enabled on open-source relational databases"
}

data "azurerm_policy_set_definition" "deploy_microsoft_defender_for_endpoint_agent_initiative" {
  name = "e20d08c5-6d64-656d-6465-ce9e37fd0ebc" #"[Preview]: Deploy Microsoft Defender for Endpoint agent"
}

data "azurerm_policy_set_definition" "deploy_microsoft_defender_for_databases_initiative" {
  name = "9d46421d-1a48-4636-8d1a-5525ed29172d" #"Configure Microsoft Defender for Databases to be enabled"
}

##################
# Monitoring
##################

data "azurerm_policy_set_definition" "deploy_enable_azure_monitor_for_virtual_machines_initiative" {
  name = "55f3eceb-5573-4f18-9695-226972c6d74a" #"Legacy - Enable Azure Monitor for VMs"
}

data "azurerm_policy_set_definition" "deploy_enable_azure_monitor_for_virtual_machines_scale_sets_initiative" {
  name = "75714362-cae7-409e-9b99-a8e5075b7fad" #"Legacy - Enable Azure Monitor for Virtual Machine Scale Sets"
}

data "azurerm_policy_set_definition" "audit_public_network_access_initiative" {
  name = "f1535064-3294-48fa-94e2-6e83095a5c08" #"Audit Public Network Access"
}

##################
# Networking
##################

data "azurerm_policy_set_definition" "deploy_flow_logs_should_be_configured_and_enabled_for_every_network_security_group_initiative" {
  name = "62329546-775b-4a3d-a4cb-eb4bb990d2c0" #"Flow logs should be configured and enabled for every network security group"
}

##################
# SQL
##################

data "azurerm_policy_set_definition" "audit_aad_admin_should_be_provisioned_for_SQL_servers_initiative" {
  name = "62329546-775b-4a3d-a4cb-eb4bb990d2c0" #"An Azure Active Directory administrator should be provisioned for SQL servers"
}