# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# This is a sample configuration file for the MPE Landing Zone Policy Starter.
# This file is used to configure the MPE Landing Zone.  
# It is used to set the default values for the variables used in the MPE Landing Zone.  The values in this file can be overridden by setting the same variable in the terraform.tfvars file.

###########################
## Global Configuration  ##
###########################

# The prefixes to use for all resources in this deployment
org_name           = "ampe"   # This Prefix will be used on most deployed resources.  10 Characters max.
environment        = "public" # public | usgovernment
deploy_environment = "prod"   # dev | test | prod

# The default region to deploy to
default_location = "eastus"

##########################
# Policy Configuration  ##
##########################

# The policy definition id for the policy definition to be assigned to the subscription.  This policy definition id can be obtained from the Azure Policy portal.

skip_remediation       = false # set to true to skip remediation of existing resources
skip_role_assignment   = false # set to true to skip role assignment
re_evaluate_compliance = false # set to true to re-evaluate compliance

policy_non_compliance_message_enabled         = true         # set to true to enable the policy non-compliance message
policy_non_compliance_message_default_enabled = true         # set to true to enable the policy non-compliance message by default
policy_exemption_expires_on                   = "2025-12-31" # The date the policy exemption expires

#################################
# General Policy Configuration ##
#################################

listOfAllowedLocations = ["eastus", "eastus2", "westus2", "westus", ] # list of allowed locations for resources
listOfAllowedSKUs = [
  "Standard_D1_v2",
  "Standard_D2_v2",
  "Standard_D3_v2",
  "Standard_D4_v2",
  "Standard_D11_v2",
  "Standard_D12_v2",
  "Standard_D13_v2",
  "Standard_D14_v2",
  "Standard_DS1_v2",
  "Standard_DS2_v2",
  "Standard_DS3_v2",
  "Standard_DS4_v2",
  "Standard_DS5_v2",
  "Standard_DS11_v2",
  "Standard_DS12_v2",
  "Standard_DS13_v2",
  "Standard_DS14_v2",
  "Standard_M8-2ms",
  "Standard_M8-4ms",
  "Standard_M8ms",
  "Standard_M16-4ms",
  "Standard_M16-8ms",
  "Standard_M16ms",
  "Standard_M32-8ms",
  "Standard_M32-16ms",
  "Standard_M32ls",
  "Standard_M32ms",
  "Standard_M32ts",
  "Standard_M64-16ms",
  "Standard_M64-32ms",
  "Standard_M64ls",
  "Standard_M64ms",
  "Standard_M64s",
  "Standard_M128-32ms",
  "Standard_M128-64ms",
  "Standard_M128ms",
  "Standard_M128s",
  "Standard_M64",
  "Standard_M64m",
  "Standard_M128",
  "Standard_M128m",
  "Standard_D1",
  "Standard_D2",
  "Standard_D3",
  "Standard_D4",
  "Standard_D11",
  "Standard_D12",
  "Standard_D13",
  "Standard_D14",
  "Standard_DS15_v2",
  "Standard_NV6",
  "Standard_NV12",
  "Standard_NV24",
  "Standard_F2s_v2",
  "Standard_F4s_v2",
  "Standard_F8s_v2",
  "Standard_F16s_v2",
  "Standard_F32s_v2",
  "Standard_F64s_v2",
  "Standard_F72s_v2",
  "Standard_NC6s_v3",
  "Standard_NC12s_v3",
  "Standard_NC24rs_v3",
  "Standard_NC24s_v3",
  "Standard_NC6",
  "Standard_NC12",
  "Standard_NC24",
  "Standard_NC24r",
  "Standard_ND6s",
  "Standard_ND12s",
  "Standard_ND24rs",
  "Standard_ND24s",
  "Standard_NC6s_v2",
  "Standard_NC12s_v2",
  "Standard_NC24rs_v2",
  "Standard_NC24s_v2",
  "Standard_ND40rs_v2",
  "Standard_NV12s_v3",
  "Standard_NV24s_v3",
  "Standard_NV48s_v3"
] # 

#################################
# Logging Policy Configuration ##
#################################

workspaceRetentionDays = 90 # The number of days to retain logs in the Log Analytics workspace

#################################
# Network Policy Configuration ##
#################################

listofPortsToDeny = [
  "22",
  "3389"
]

listOfAllowedIPAddressesforNSGs = []

####################################
# Monitoring Policy Configuration ##
####################################

listOfResourceTypesToAuditDiagnosticSettings = [
  "Microsoft.AnalysisServices/servers",
  "Microsoft.ApiManagement/service",
  "Microsoft.Network/applicationGateways",
  "Microsoft.Automation/automationAccounts",
  "Microsoft.ContainerRegistry/registries",
  "Microsoft.ContainerService/managedClusters",
  "Microsoft.Batch/batchAccounts",
  "Microsoft.Cdn/profiles/endpoints",
  "Microsoft.CognitiveServices/accounts",
  "Microsoft.DocumentDB/databaseAccounts",
  "Microsoft.DataFactory/factories",
  "Microsoft.DataLakeAnalytics/accounts",
  "Microsoft.DataLakeStore/accounts",
  "Microsoft.EventGrid/topics",
  "Microsoft.EventHub/namespaces",
  "Microsoft.Network/expressRouteCircuits",
  "Microsoft.Network/azureFirewalls",
  "Microsoft.HDInsight/clusters",
  "Microsoft.Devices/IotHubs",
  "Microsoft.KeyVault/vaults",
  "Microsoft.Network/loadBalancers",
  "Microsoft.Logic/integrationAccounts",
  "Microsoft.Logic/workflows",
  "Microsoft.DBforMySQL/servers",
  "Microsoft.Network/networkSecurityGroups",
  "Microsoft.Network/bastionHosts",
  "Microsoft.Kusto/clusters",
  "Microsoft.DBForMariaDB/servers",
  "Microsoft.DBforPostgreSQL/servers",
  "Microsoft.PowerBIDedicated/capacities",
  "Microsoft.Network/publicIPAddresses",
  "Microsoft.RecoveryServices/vaults",
  "Microsoft.Cache/redis",
  "Microsoft.Relay/namespaces",
  "Microsoft.Search/searchServices",
  "Microsoft.ServiceBus/namespaces",
  "Microsoft.SignalRService/SignalR",
  "Microsoft.Sql/servers/databases",
  "Microsoft.StreamAnalytics/streamingjobs",
  "Microsoft.TimeSeriesInsights/environments",
  "Microsoft.Network/trafficManagerProfiles",
  //"Microsoft.Compute/virtualMachines", # Logs are collected through Microsoft Monitoring Agent
  //"Microsoft.Compute/virtualMachineScaleSets", Removed since it is not supported
  "Microsoft.Network/virtualNetworks",
  "Microsoft.Network/virtualNetworkGateways",
  "Microsoft.Web/sites",
  "Microsoft.Media/mediaservices",
]

securityContactsEmail = "anoa_admins@contoso.us"

####################################
# Key Vault Policy Configuration  ##
####################################

listOfAllowedIPAddresses = []

#########################################
# Cost Management Policy Configuration ##
#########################################

budget_amount = "10000" # The budget amount
