# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
  PARAMETERS
  Here are all the variables a user can override.
*/

#################################
# Global Configuration
#################################

variable "deploy_environment" {
  description = "Name of the workload's environnement (dev, test, prod, etc). This will be used to name the resources deployed by this module. default is 'dev'"
  type        = string
}

variable "environment" {
  description = "Name of the environment. This will be used to name the private endpoint resources deployed by this module. default is 'public'"
  type        = string
  default     = "public"
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
  description = "If specified, identifies the subscription to deploy resources to. If not specified, the default subscription will be used."
  sensitive   = true
  default = null
  validation {
    condition     = can(regex("^[a-z0-9-]{36}$", var.subscription_id_hub)) || var.subscription_id_hub == ""
    error_message = "Value must be a valid Subscription ID (GUID)."
  }
}