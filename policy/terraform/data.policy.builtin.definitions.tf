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

data "azurerm_policy_definition" "not_allowed_resource_types" {
  name = "6c112d4e-5bc7-47ae-a041-ea2d9dccd749" # "[Preview]: Not Allowed resource types"
}

data "azurerm_policy_definition" "allowed_regions" {
  name = "e56962a6-4747-49cd-b67b-bf8b01975c4c" # "[Preview]: Allowed Azure Regions"
}

data "azurerm_policy_definition" "allowed_virtual_machine_sizes" {
  name = "cccc23c7-8427-4f53-ad12-b6a63eb452b3" # "[Preview]: Allowed virtual machine sizes"
}

#####################
# Microsoft Entra ID
#####################

data "azurerm_policy_definition" "audit_aad_should_use_private_link_to_access_Azure_services" {
  name = "2e9411a0-0c5a-44b3-9ddb-ff10a1a2bf28" # "Azure Active Directory should use private link to access Azure services"
}

data "azurerm_policy_definition" "deploy_configure_private_link_for_AAD_to_use_private_DNS_zones" {
  name = "7e4301f9-5f32-4738-ad9f-7ec2d15563ad" # "Configure Private Link for Azure AD to use private DNS zones"
}

##################
# Network
##################

data "azurerm_policy_definition" "deploy_internet_traffic_should_be_routed_via_deployed_azure_firewall" {
  name = "fc5e4038-4584-4632-8c85-c0448d374b2c" # "[Preview]: All Internet traffic should be routed via your deployed Azure Firewall"
}

data "azurerm_policy_definition" "audit_subscription_should_configure_the_Azure_Firewall_Premium_to_provide_additional_layer_of_protection" {
  name = "f2c2d0a6-e183-4fc8-bd8f-363c65d3bbbf" # "Subscription should configure the Azure Firewall Premium to provide additional layer of protection"
}

data "azurerm_policy_definition" "deploy_configure_virtual_network_to_enable_traffic_analytics" {
  name = "3e9965dc-cc13-47ca-8259-a4252fd0cf7b" # "Configure virtual network to enable traffic analytics"
}

data "azurerm_policy_definition" "deploy_configure_network_security_groups_to_enable_traffic_analytics" {
  name = "e920df7f-9a64-4066-9b58-52684c02a091" # "Configure network security groups to enable traffic analytics"
}

data "azurerm_policy_definition" "audit_network_watcher_flow_logs_should_have_traffic_analytics_enabled" {
  name = "2f080164-9f4d-497e-9db6-416dc9f7b48a" # "Network Watcher flow logs should have traffic analytics enabled"
}

data "azurerm_policy_definition" "audit_flow_logs_should_be_configured_for_every_network_security_group" {
  name = "c251913d-7d24-4958-af87-478ed3b9ba41" # "Flow logs should be configured for every network security group"
}

data "azurerm_policy_definition" "audit_flow_logs_should_be_configured_for_every_virtual_network" {
  name = "4c3c6c5f-0d47-4402-99b8-aa543dd8bcee" # "Flow logs should be configured for every virtual network"
}

data "azurerm_policy_definition" "deploy_configure_nsg_to_use_specific_retention_policy_for_traffic_analytics" {
  name = "5e1cd26a-5090-4fdb-9d6a-84a90335e22d" # "Configure network security groups to use specific workspace, storage account and flowlog retention policy for traffic analytics"
}

data "azurerm_policy_definition" "deploy_azure_DDoS_protection_standard_should_be_enabled" {
  name = "a7aca53f-2ed4-4466-a25e-0b45ade68efd" #"Azure DDoS Protection Standard should be enabled"
}

data "azurerm_policy_definition" "deny_network_interfaces_should_not_have_public_IPs" {
  name = "83a86a26-fd1f-447c-b59d-e51f44264114" #"Network interfaces should not have public IPs"
}

##################
# Storage
##################

data "azurerm_policy_definition" "deploy_storage_accounts_should_have_min_tls_version" {
  name = "fe83a0eb-a853-422d-aac2-1bffd182c5d0" # "Storage accounts should have the specified minimum TLS version"
}

data "azurerm_policy_definition" "audit_storage_accounts_should_allow_access_from_trusted_Microsoft_services" {
  name = "c9d007d0-c057-4772-b18c-01e546713bcd" # "Storage accounts should allow access from trusted Microsoft services"
}

data "azurerm_policy_definition" "audit_storage_accounts_should_be_configured_to_use_encryption" {
  name = "b2982f36-99f2-4db5-8eff-283140c09693" # "Storage accounts should disable public network access"
}

data "azurerm_policy_definition" "audit_storage_accounts_should_use_customer_managed_key_for_encryption" {
  name = "6fac406b-40ca-413b-bf8e-0bf964659c25" # "Storage accounts should use customer-managed key for encryption, use in IL5"
}

data "azurerm_policy_definition" "deploy_storage_accounts_should_prevent_cross_tenant_object_replication" {
  name = "92a89a79-6c52-4a7e-a03f-61306fc49312" # "Storage accounts should prevent cross tenant object replication"
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

data "azurerm_policy_definition" "audit_vaults_should_use_private_link" {
  name = "a6abeaec-4d90-4a02-805f-6b26c4d3fbe9" # "Azure Key Vaults should use private link"
}

######################
# Defender for Cloud
######################

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_subscriptions" {
  name = "ac076320-ddcf-4066-b451-6154267e8ad2" # "Enable Microsoft Defender for Cloud on your subscription"
}

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_oss_db_services" {
  name = "44433aa3-7ec2-4002-93ea-65c65ff0310a" # "Microsoft Defender for Cloud should be configured for Azure Database for MySQL servers"
}

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_azure_storage_accounts_V2" {
  name = "cfdc5972-75b3-4418-8ae1-7f5c36839390" # "Microsoft Defender for Cloud should be configured for Azure Storage Accounts V2"
}

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_azure_vm_vulnerability_assessment" {
  name = "13ce0167-8ca6-4048-8e6b-f996402e3c1b" # "Microsoft Defender for Cloud should be configured for Azure VM Vulnerability Assessment"
}

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_azure_kubernetes_services_clusters" {
  name = "64def556-fbad-4622-930e-72d1d5589bf5" # "Microsoft Defender for Cloud should be configured for Azure Kubernetes Services Clusters"
}

data "azurerm_policy_definition" "deploy_mdfc_should_be_configured_for_azure_app_services" {
  name = "b40e7bcd-a1e5-47fe-b9cf-2f534d0bfb7d" # "Microsoft Defender for Cloud should be configured for Azure App Services"
}

data "azurerm_policy_definition" "deploy_configure_azure_defender_to_be_enabled_on_SQL_servers" {
  name = "50ea7265-7d8c-429e-9a7d-ca1f410191c3" # "Configure Azure Defender for SQL servers on machines to be enabled"
}

data "azurerm_policy_definition" "deploy_configure_azure_defender_to_be_enabled_on_azure_SQL_databases" {
  name = "b99b73e7-074b-4089-9395-b7236f094491" # "Configure Azure Defender for Azure SQL database to be enabled"
}

#######################
# Guest Configuration
#######################

data "azurerm_policy_definition" "modify_add_system_assigned_managed_identity_to_enable_guest_configuration_assignments_on_virtual_machines_with_no_identities" {
  name = "3cf2ab00-13f1-4d0c-8971-2ac904541a7e" # "Add system-assigned managed identity to enable Guest Configuration assignments on virtual machines with no identities"
}

data "azurerm_policy_definition" "deploy_the_linux_guest_configuration_extension_to_enable_guest_configuration_assignments_on_linux_vms" {
  name = "331e8ea8-378a-410f-a2e5-ae22f38bb0da" # "Deploy the Linux Guest Configuration extension to enable Guest Configuration assignments on Linux VMs"
}

data "azurerm_policy_definition" "deploy_the_windows_guest_configuration_extension_to_enable_guest_configuration_assignments_on_windows_vms" {
  name = "385f5831-96d4-41db-9a3c-cd3af78aaae6" # "Deploy the Windows Guest Configuration extension to enable Guest Configuration assignments on Windows VMs"
}

data "azurerm_policy_definition" "audit_windows_machines_should_meet_requirements_of_the_Azure_compute_security_baseline" {
  name = "72650e9f-97bc-4b2a-ab5f-9781a9fcecbc" # "Windows machines should meet requirements of the Azure compute security baseline"
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

data "azurerm_policy_definition" "deploy_diagnostic_settings_should_be_configured_for_azure_network_security_groups" {
  name = "c9c29499-c1d1-4195-99bd-2ec9e3a9dc89" # "Configure diagnostic settings for Azure Network Security Groups to Log Analytics workspace"
}

data "azurerm_policy_definition" "deploy_configure_azure_activity_logs_to_stream_to_specified_log_analytics_workspace" {
  name = "2465583e-4e78-4c15-b6be-a36cbc7c8b0f" # "Configure Azure Activity logs to stream to specified Log Analytics workspace"
}

data "azurerm_policy_definition" "deploy_configure_azure_log_analytics_workspaces_to_disable_public_network_access_for_log_ingestion_and_querying" {
  name = "d3ba9c42-9dd5-441a-957c-274031c750c0" # "Configure Azure Log Analytics workspaces to disable public network access for log ingestion and querying"
}

#################
# Sql
#################

data "azurerm_policy_definition" "deploy_sql_db_transparent_data_encryption" {
  name = "86a912f6-9a06-4e26-b447-11b16ba8659f" # "Deploy SQL DB transparent data encryption"
}

data "azurerm_policy_definition" "deploy_configure_advanced_threat_protection_to_be_enabled_on_mysql_servers" {
  name = "80ed5239-4122-41ed-b54a-6f1fa7552816" #"Configure Advanced Threat Protection to be enabled on SQL Managed Instances"
}

data "azurerm_policy_definition" "deploy_configure_advanced_threat_protection_to_be_enabled_on_PostgreSQL_servers" {
  name = "db048e65-913c-49f9-bb5f-1084184671d3" #"Configure Advanced Threat Protection to be enabled on SQL Servers"
}