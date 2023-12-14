# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
SUMMARY: Module to deploy Policy Definitions for Azure Policy in Management Groups.
DESCRIPTION: The following components will be options in this deployment
             * Builtin Policy Definitions
AUTHOR/S: jspinella
*/


#######################
# Built-In Definitions
#######################

##################
# General
##################

data "azurerm_policy_definition" "allowed_resource_types" {
  name = "a08ec900-254a-4555-9bf5-e42af04b5c5c" # "[Preview]: Allowed resource types"
}

data "azurerm_policy_definition" "not_allowed_resource_types" {
  name = "6c112d4e-5bc7-47ae-a041-ea2d9dccd749" # "[Preview]: Not Allowed resource types"
}

data "azurerm_policy_definition" "allowed_regions" {
  name = "e56962a6-4747-49cd-b67b-bf8b01975c4c" # "[Preview]: Allowed Azure Regions"
}

data "azurerm_policy_definition" "allowed_virtual_machine_sizes" {
  name = "cccc23c7-8427-4f53-ad12-b6a63eb452b3" # "[Preview]: Allowed virtual machine sizes"
}

##################
# Network
##################

data "azurerm_policy_definition" "deploy_internet_traffic_should_be_routed_via_deployed_azure_firewall" {
  name = "fc5e4038-4584-4632-8c85-c0448d374b2c" # "[Preview]: All Internet traffic should be routed via your deployed Azure Firewall"
}

data "azurerm_policy_definition" "deploy_configure_network_security_groups_to_enable_traffic_analytics" {
  name = "e920df7f-9a64-4066-9b58-52684c02a091" # "Configure network security groups to enable traffic analytics"
}

data "azurerm_policy_definition" "audit_flow_logs_should_be_configured_for_every_network_security_group" {
  name = "a3e4f4c1-4ce4-4d1c-8f43-0f9aee97c1c2" # "Flow logs should be configured for every network security group"
}

data "azurerm_policy_definition" "deny_not_allowed_resource_types_public_ips" {
  name = "a3e4f4c1-4ce4-4d1c-8f43-0f9aee97c1c2" # "Not allowed resource types - public ips"
}

data "azurerm_policy_definition" "deploy_configure_nsg_to_use_specific_retention_policy_for_traffic_analytics" {
  name = "a3e4f4c1-4ce4-4d1c-8f43-0f9aee97c1c2" # "Configure network security groups to use specific workspace, storage account and flowlog retention policy for traffic analytics"
}

data "azurerm_policy_definition" "deploy_azure_DDoS_protection_standard_should_be_enabled" {
  name = "a7aca53f-2ed4-4466-a25e-0b45ade68efd" #"Azure DDoS Protection Standard should be enabled"
}

##################
# Storage
##################

data "azurerm_policy_definition" "deploy_storage_accounts_should_be_configured_to_use_azure_key_vault" {
  name = "a3e4f4c1-4ce4-4d1c-8f43-0f9aee97c1c2" # "Storage accounts should be configured to use Azure Key Vault"
}

data "azurerm_policy_definition" "deploy_storage_accounts_should_be_configured_to_use_encryption" {
  name = "a3e4f4c1-4ce4-4d1c-8f43-0f9aee97c1c2" # "Storage accounts should be configured to use encryption"
}

data "azurerm_policy_definition" "deploy_storage_accounts_should_be_configured_to_use_https_traffic_only" {
  name = "a3e4f4c1-4ce4-4d1c-8f43-0f9aee97c1c2" # "Storage accounts should be configured to use HTTPS traffic only"
}

###################
# Key Vault
###################

data "azurerm_policy_definition" "deploy_key_vaults_should_be_configured_to_use_soft_delete" {
  name = "1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d" # "Key vaults should be configured to use soft delete"
}

data "azurerm_policy_definition" "deploy_key_vaults_should_be_configured_to_use_purge_protection" {
  name = "0b60c0b2-2dc2-4e1c-b5c9-abbed971de53" # "Key vaults should be configured to use purge protection"
}

data "azurerm_policy_definition" "deploy_key_vaults_secrets_should_have_an_expiration_date" {
  name = "98728c90-32c7-4049-8429-847dc0f4fe37" # "Key Vault secrets should have an expiration date"
}

data "azurerm_policy_definition" "deploy_key_vaults_keys_should_have_an_expiration_date" {
  name = "152b15f7-8e1f-4c1f-ab71-8c010ba5dbc0" # "Key Vault keys should have an expiration date"
}

data "azurerm_policy_definition" "deploy_key_vaults_should_have_firewall_enabled" {
  name = "55615ac9-af46-4a59-874e-391cc3dfb490" # "Azure Key Vault should have firewall enabled"
}

data "azurerm_policy_definition" "deploy_certificates_should_have_the_specified_lifetime_action_triggers" {
  name = "12ef42cb-9903-4e39-9c26-422d29570417" # "Certificates should have the specified lifetime action triggers"
}

data "azurerm_policy_definition" "deploy_keys_should_have_more_than_the_specified_number_of_days_before_expiration" {
  name = "5ff38825-c5d8-47c5-b70e-069a21955146" # "Keys should have more than the specified number of days before expiration"
}

data "azurerm_policy_definition" "deploy_secrets_should_have_more_than_the_specified_number_of_days_before_expiration" {
  name = "b0eb591a-5e70-4534-a8bf-04b9c489584a" # "Secrets should have more than the specified number of days before expiration"
}

######################
# Defender for Cloud
######################

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_oss_db_services" {
  name = "44433aa3-7ec2-4002-93ea-65c65ff0310a" # "Microsoft Defender for Cloud should be configured for Azure Database for MySQL servers"
}

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_azure_sql_servers" {
  name = "a3e4f4c1-4ce4-4d1c-8f43-0f9aee97c1c2" # "Microsoft Defender for Cloud should be configured for Azure SQL Servers"
}

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_azure_storage_accounts_V2" {
  name = "cfdc5972-75b3-4418-8ae1-7f5c36839390" # "Microsoft Defender for Cloud should be configured for Azure Storage Accounts V2"
}

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_azure_vm_vulnerability_assessment" {
  name = "13ce0167-8ca6-4048-8e6b-f996402e3c1b" # "Microsoft Defender for Cloud should be configured for Azure VM Vulnerability Assessment"
}

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_sql_server_virtual_machines" {
  name = "50ea7265-7d8c-429e-9a7d-ca1f410191c3" # "Microsoft Defender for Cloud should be configured for SQL Server Virtual Machines"
}

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_azure_kubernetes_services_clusters" {
  name = "64def556-fbad-4622-930e-72d1d5589bf5" # "Microsoft Defender for Cloud should be configured for Azure Kubernetes Services Clusters"
}

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_azure_virtual_machine_scale_sets" {
  name = "a3e4f4c1-4ce4-4d1c-8f43-0f9aee97c1c2" # "Microsoft Defender for Cloud should be configured for Azure Virtual Machine Scale Sets"
}

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_azure_app_services" {
  name = "b40e7bcd-a1e5-47fe-b9cf-2f534d0bfb7d" # "Microsoft Defender for Cloud should be configured for Azure App Services"
}

##################
# Montioring
##################

data "azurerm_policy_definition" "deploy_diagnostic_settings_should_be_configured_for_azure_storage_account" {
  name = "59759c62-9a22-4cdf-ae64-074495983fef" # "Deploys the diagnostic settings for Storage accounts to stream resource logs to a Log Analytics workspace when any storage accounts which is missing this diagnostic settings is created or updated."
}

data "azurerm_policy_definition" "deploy_monitoring_should_be_configured_for_azure_storage_account_blob_services" {
  name = "b4fe1a3b-0715-4c6c-a5ea-ffc33cf823cb" # "Monitoring should be configured for Azure Storage Account Blob Services"
}

data "azurerm_policy_definition" "deploy_monitoring_should_be_configured_for_azure_storage_account_file_services" {
  name = "25a70cc8-2bd4-47f1-90b6-1478e4662c96" # "Monitoring should be configured for Azure Storage Account File Services"
}

data "azurerm_policy_definition" "deploy_monitoring_should_be_configured_for_azure_storage_account_queue_services" {
  name = "7bd000e3-37c7-4928-9f31-86c4b77c5c45" # "Monitoring should be configured for Azure Storage Account Queue Services"
}

data "azurerm_policy_definition" "deploy_monitoring_should_be_configured_for_azure_storage_account_table_services" {
  name = "2fb86bf3-d221-43d1-96d1-2434af34eaa0" # "Monitoring should be configured for Azure Storage Account Table Services"
}

data "azurerm_policy_definition" "deploy_monitoring_should_be_configured_for_azure_AKS" {
  name = "6c66c325-74c8-42fd-a286-a74b0e2939d8" # "Monitoring should be configured for Azure AKS"
}

data "azurerm_policy_definition" "deploy_monitoring_should_be_configured_for_azure_batch" {
  name = "c84e5349-db6d-4769-805e-e14037dab9b5" # "Monitoring should be configured for Azure Batch"
}

data "azurerm_policy_definition" "deploy_monitoring_should_be_configured_for_azure_data_lake_store" {
  name = "d56a5a7c-72d7-42bc-8ceb-3baf4c0eae03" # "Monitoring should be configured for Azure Data Lake Store"
}

data "azurerm_policy_definition" "deploy_monitoring_should_be_configured_for_azure_key_vault" {
  name = "bef3f64c-5290-43b7-85b0-9b254eef4c47" # "Monitoring should be configured for Azure Key Vault"
}

data "azurerm_policy_definition" "deploy_monitoring_should_be_configured_for_azure_logic_apps" {
  name = "b889a06c-ec72-4b03-910a-cb169ee18721" # "Monitoring should be configured for Azure Logic Apps"
}

data "azurerm_policy_definition" "deploy_monitoring_should_be_configured_for_azure_network_security_groups" {
  name = "98a2e215-5382-489e-bd29-32e7190a39ba" # "Configure diagnostic settings for Azure Network Security Groups to Log Analytics workspace"
}

#################
# Sql
#################

data "azurerm_policy_definition" "deploy_sql_db_transparent_data_encryption" {
  name = "86a912f6-9a06-4e26-b447-11b16ba8659f" # "Deploy SQL DB transparent data encryption"
}
