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

data "azurerm_policy_set_definition" "deploy_configure_advanced_threat_protection_to_be_enabled_on_open_source_relational_databases_initiative" {
  name = "e77fc0b3-f7e9-4c58-bc13-cb753ed8e46e" #"Configure Advanced Threat Protection to be enabled on open-source relational databases"
}