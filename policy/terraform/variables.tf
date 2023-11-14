# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
  PARAMETERS
  Here are all the variables a user can override.
*/

#################################
# Global Configuration
#################################
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

variable "subscription_id_hub" {
  type        = string
  description = "If specified, identifies the Platform subscription for \"Hub\" for resource deployment and correct placement in the Management Group hierarchy."

  validation {
    condition     = can(regex("^[a-z0-9-]{36}$", var.subscription_id_hub)) || var.subscription_id_hub == ""
    error_message = "Value must be a valid Subscription ID (GUID)."
  }
  sensitive = true
}

variable "hub_resource_group_name" {
  type        = string
  description = "Concatenated with the \"subscription_id_hub\" to identify the \"Hub\" Resource Group used for Policy Exemptions."
  default     = "anoa-eus-hub-core-test-rg"
}

variable "subscription_id_app1" {
  type        = string
  description = "If specified, identifies the Workload subscription containing your first application for resource deployment."
  default     = ""

  validation {
    condition     = can(regex("^[a-z0-9-]{36}$", var.subscription_id_app1)) || var.subscription_id_app1 == ""
    error_message = "Value must be a valid Subscription ID (GUID)."
  }
  sensitive = true
}

variable "app1_resource_group_name" {
  type        = string
  description = "Concatenated with the \"subscription_id_app1\" to identify the \"App1\" Resource Group used for Policy Exemptions."
  default     = "anoa-app1-eus-prod-rg"
}



variable "subscription_id_app2" {
  type        = string
  description = "If specified, identifies the Workload subscription containing your second application for resource deployment."
  default     = ""

  validation {
    condition     = can(regex("^[a-z0-9-]{36}$", var.subscription_id_app2)) || var.subscription_id_app2 == ""
    error_message = "Value must be a valid Subscription ID (GUID)."
  }
  sensitive = true
}

variable "app2_resource_group_name" {
  type        = string
  description = "Concatenated with the \"subscription_id_app1\" to identify the \"App2\" Resource Group used for Policy Exemptions."
  default     = "anoa-app2-eus-prod-rg"
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

##########################
# Policy Configuration  ##
##########################

variable "skip_remediation" {
  type        = bool
  description = "Skip creation of all remediation tasks for policies that DeployIfNotExists and Modify"
  default     = true
}

variable "skip_role_assignment" {
  type        = bool
  description = "Should the module skip creation of role assignment for policies that DeployIfNotExists and Modify"
  default     = false
}

variable "re_evaluate_compliance" {
  type        = bool
  description = "Should the module re-evaluate compliant resources for policies that DeployIfNotExists and Modify"
  default     = false
}

variable "create_duration_delay" {
  type = object({
    azurerm_management_group      = optional(string, "30s")
    azurerm_policy_assignment     = optional(string, "30s")
    azurerm_policy_definition     = optional(string, "30s")
    azurerm_policy_set_definition = optional(string, "30s")
    azurerm_role_assignment       = optional(string, "0s")
    azurerm_role_definition       = optional(string, "60s")
  })
  description = "Used to tune terraform apply when faced with errors caused by API caching or eventual consistency. Sets a custom delay period after creation of the specified resource type."
  default = {
    azurerm_management_group      = "30s"
    azurerm_policy_assignment     = "30s"
    azurerm_policy_definition     = "30s"
    azurerm_policy_set_definition = "30s"
    azurerm_role_assignment       = "0s"
    azurerm_role_definition       = "60s"
  }

  validation {
    condition     = can([for v in values(var.create_duration_delay) : regex("^[0-9]{1,6}(s|m|h)$", v)])
    error_message = "The create_duration_delay values must be a string containing the duration in numbers (1-6 digits) followed by the measure of time represented by s (seconds), m (minutes), or h (hours)."
  }
}

variable "destroy_duration_delay" {
  type = object({
    azurerm_management_group      = optional(string, "0s")
    azurerm_policy_assignment     = optional(string, "0s")
    azurerm_policy_definition     = optional(string, "0s")
    azurerm_policy_set_definition = optional(string, "0s")
    azurerm_role_assignment       = optional(string, "0s")
    azurerm_role_definition       = optional(string, "0s")
  })
  description = "Used to tune terraform deploy when faced with errors caused by API caching or eventual consistency. Sets a custom delay period after destruction of the specified resource type."
  default = {
    azurerm_management_group      = "0s"
    azurerm_policy_assignment     = "0s"
    azurerm_policy_definition     = "0s"
    azurerm_policy_set_definition = "0s"
    azurerm_role_assignment       = "0s"
    azurerm_role_definition       = "0s"
  }

  validation {
    condition     = can([for v in values(var.destroy_duration_delay) : regex("^[0-9]{1,6}(s|m|h)$", v)])
    error_message = "The destroy_duration_delay values must be a string containing the duration in numbers (1-6 digits) followed by the measure of time represented by s (seconds), m (minutes), or h (hours)."
  }
}

variable "custom_policy_roles" {
  type        = map(list(string))
  description = "If specified, the custom_policy_roles variable overrides which Role Definition ID(s) (value) to assign for Policy Assignments with a Managed Identity, if the assigned \"policyDefinitionId\" (key) is included in this variable."
  default     = {}
}

variable "policy_non_compliance_message_enabled" {
  type        = bool
  description = "If set to false, will disable non-compliance messages altogether."
  default     = true
}

variable "policy_non_compliance_message_not_supported_definitions" {
  type        = list(string)
  description = "If set, overrides the list of built-in policy definition that do not support non-compliance messages."
  default = [
    "/providers/Microsoft.Authorization/policyDefinitions/1c6e92c9-99f0-4e55-9cf2-0c234dc48f99",
    "/providers/Microsoft.Authorization/policyDefinitions/1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d",
    "/providers/Microsoft.Authorization/policyDefinitions/95edb821-ddaf-4404-9732-666045e056b4"
  ]
}

variable "policy_non_compliance_message_default_enabled" {
  type        = bool
  description = "If set to true, will enable the use of the default custom non-compliance messages for policy assignments if they are not provided."
  default     = true
}

variable "policy_non_compliance_message_default" {
  type        = string
  description = "If set overrides the default non-compliance message used for policy assignments."
  default     = "This resource {enforcementMode} be compliant with the assigned policy."
  validation {
    condition     = var.policy_non_compliance_message_default != null && length(var.policy_non_compliance_message_default) > 0
    error_message = "The policy_non_compliance_message_default value must not be null or empty."
  }
}

variable "policy_non_compliance_message_enforcement_placeholder" {
  type        = string
  description = "If set overrides the non-compliance message placeholder used in message templates."
  default     = "{enforcementMode}"
  validation {
    condition     = var.policy_non_compliance_message_enforcement_placeholder != null && length(var.policy_non_compliance_message_enforcement_placeholder) > 0
    error_message = "The policy_non_compliance_message_enforcement_placeholder value must not be null or empty."
  }
}

variable "policy_non_compliance_message_enforced_replacement" {
  type        = string
  description = "If set overrides the non-compliance replacement used for enforced policy assignments."
  default     = "must"
  validation {
    condition     = var.policy_non_compliance_message_enforced_replacement != null && length(var.policy_non_compliance_message_enforced_replacement) > 0
    error_message = "The policy_non_compliance_message_enforced_replacement value must not be null or empty."
  }
}

variable "policy_non_compliance_message_not_enforced_replacement" {
  type        = string
  description = "If set overrides the non-compliance replacement used for unenforced policy assignments."
  default     = "should"
  validation {
    condition     = var.policy_non_compliance_message_not_enforced_replacement != null && length(var.policy_non_compliance_message_not_enforced_replacement) > 0
    error_message = "The policy_non_compliance_message_not_enforced_replacement value must not be null or empty."
  }
}

