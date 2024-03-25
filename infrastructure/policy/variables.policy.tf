# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
  PARAMETERS
  Here are all the variables a user can override.
*/

###########
# Policy ##
###########

variable "securityContactsEmail" {
  type        = string
  description = "If specified, identifies the email address to send security alerts to."
  default     = "anoa@contoso.com"
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.securityContactsEmail)) || var.securityContactsEmail == ""
    error_message = "Value must be a valid email address format."
  }
  sensitive = true
}

variable "listOfAllowedLocations" {
  type        = list(string)
  description = "If specified, identifies the list of allowed locations for resources."
  default     = []
}

variable "listOfAllowedResourceTypes" {
  type        = list(string)
  description = "If specified, identifies the list of allowed resource types."
  default     = []
}

variable "listOfAllowedSKUs" {
  type        = list(string)
  description = "If specified, identifies the list of allowed SKUs."
  default     = []
}

variable "listOfAllowedTags" {
  type        = list(string)
  description = "If specified, identifies the list of allowed resource tags."
  default     = []
}

variable "listOfAllowedIPAddresses" {
  type        = list(string)
  description = "If specified, identifies the list of allowed IP addresses for Key Vault."
  default     = []
}

variable "minimumDaysBeforeExpiration" {
  type        = number
  description = "If specified, identifies the minimum number of days before a secret or key expires."
  default     = 90
}

variable "listofPortsToDeny" {
  type        = list(number)
  description = "If specified, identifies the list of allowed ports."
  default     = []  
}

variable "listOfAllowedIPAddressesforNSGs" {
  type        = list(string)
  description = "If specified, identifies the list of allowed IP addresses for NSGs."
  default     = []
}

variable "policy_exemption_expires_on" {
  type        = string
  description = "If specified, identifies the date when the policy exemption expires."
  default     = "2022-12-31"
  validation {
    condition     = can(regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}$", var.policy_exemption_expires_on)) || var.policy_exemption_expires_on == ""
    error_message = "Value must be a valid date format."
  }  
}

variable "workspaceRetentionDays" {
  type        = number
  description = "If specified, identifies the number of days to retain logs in the Log Analytics workspace."
  default     = 30  
}

variable "budget_amount" {
  type        = string
  description = "If specified, identifies the budget amount."
  default     = "10000"
}

variable "listOfResourceTypesToAuditDiagnosticSettings" {
  type        = list(string)
  description = "If specified, identifies the list of allowed resource tags."
  default = [
    "Microsoft.AnalysisServices/servers",
    "Microsoft.ApiManagement/service",
    "Microsoft.Network/applicationGateways",
    "Microsoft.Automation/automationAccounts",
    // "Microsoft.ContainerInstance/containerGroups",  # Removed since it doesn",t have any logs
    "Microsoft.ContainerRegistry/registries",
    "Microsoft.ContainerService/managedClusters",
    "Microsoft.Batch/batchAccounts",
    "Microsoft.Cdn/profiles/endpoints",
    "Microsoft.CognitiveServices/accounts",
    "Microsoft.DocumentDB/databaseAccounts",
    "Microsoft.DataFactory/factories",
    "Microsoft.DataLakeAnalytics/accounts",
    "Microsoft.DataLakeStore/accounts",
    "Microsoft.EventGrid/systemTopics",
    //"Microsoft.EventGrid/eventSubscriptions", # Removed since it doesn",t have any logs
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
    //"Microsoft.Network/networkInterfaces", # Removed since it doesn",t have any logs
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
    //"Microsoft.Sql/servers/elasticPools", # Removed since it doesn",t have any logs
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
}
