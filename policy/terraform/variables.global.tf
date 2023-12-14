# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
  PARAMETERS
  Here are all the variables a user can override.
*/

#################################
# Global Configuration
#################################

variable "environment" {
  description = "Name of the environment. This will be used to name the private endpoint resources deployed by this module. default is 'public'"
  type        = string
}

variable "org_name" {
  description = "Name of the organization. This will be used to name the resources deployed by this module. default is 'anoa'"
  type        = string
  default     = "anoa"
}

variable "default_location" {
  type        = string
  description = "If specified, will set the Azure region in which region bound resources will be deployed. Please see: https://azure.microsoft.com/en-gb/global-infrastructure/geographies/"
  default     = "eastus"
}

variable "root_management_group_id" {
  type        = string
  description = "If specified, will set a custom Name (ID) value for the \"root\" Management Group, and append this to the ID for all core Management Groups."
  default     = "anoa"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{2,10}$", var.root_management_group_id))
    error_message = "Value must be between 2 to 10 characters long, consisting of alphanumeric characters and hyphens."
  }
}

variable "root_management_group_display_name" {
  type        = string
  description = "If specified, will set a custom Display Name value for the \"root\" Management Group."
  default     = "anoa"

  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9- ._]{1,22}[A-Za-z0-9]?$", var.root_management_group_display_name))
    error_message = "Value must be between 2 to 24 characters long, start with a letter, end with a letter or number, and can only contain space, hyphen, underscore or period characters."
  }
}

variable "disable_telemetry" {
  type        = bool
  description = "If set to true, will disable telemetry for all resources deployed by this module."
  default     = false
}

variable "subscription_id_hub" {
  type        = string
  description = "If specified, identifies the Platform subscription for \"Hub\" for resource deployment and correct placement in the Management Group hierarchy."
  sensitive   = true
  validation {
    condition     = can(regex("^[a-z0-9-]{36}$", var.subscription_id_hub)) || var.subscription_id_hub == ""
    error_message = "Value must be a valid Subscription ID (GUID)."
  }
}

variable "subscription_id_identity" {
  type        = string
  description = "If specified, identifies the Platform subscription for \"Identity\" for resource deployment and correct placement in the Management Group hierarchy."
  default     = null
  sensitive   = true
}

variable "subscription_id_operations" {
  type        = string
  description = "If specified, identifies the Platform subscription for \"Operations\" for resource deployment and correct placement in the Management Group hierarchy."
  default     = null
  sensitive   = true
}

variable "subscription_id_devsecops" {
  type        = string
  description = "If specified, identifies the Platform subscription for \"DevSecOps\" for resource deployment and correct placement in the Management Group hierarchy."
  default     = null
  sensitive   = true
}

variable "hub_resource_group_name" {
  type        = string
  description = "Concatenated with the \"subscription_id_hub\" to identify the \"Hub\" Resource Group used for Policy Exemptions."
  default     = "anoa-eus-hub-core-test-rg"
}

variable "securityContactsEmail" {
  type        = string
  description = "If specified, identifies the email address to send security alerts to."

  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.securityContactsEmail)) || var.securityContactsEmail == ""
    error_message = "Value must be a valid email address format."
  }
  sensitive = true
}