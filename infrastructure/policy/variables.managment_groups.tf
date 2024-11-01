# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

/*
  PARAMETERS
  Here are all the variables a user can override.
*/

#####################################
## Management Group Configuration  ##
#####################################
/*
variable "management_group_prefix" {
  type = string
  description = "If specified, will set the resource name prefix for management group (default value determined from \"var.root_id\")."
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{2,10}$", var.resource_prefix)) || var.resource_prefix == ""
    error_message = "Value must be between 2 to 10 characters long, consisting of alphanumeric characters and hyphens."
  }
}
*/

variable "settings" {
  type = object({
    sandbox_management_group_policies = optional(object({
      enabled = optional(bool, true) 
      create = optional(bool, false)
      name = optional(string, "sandbox")
    }), {})
    platforms_management_group_policies = optional(object({
      enabled = optional(bool, true)
      create = optional(bool, false)
      name = optional(string, "platforms")
      config = optional(object({
        deploy_azure_key_vault_config          = optional(bool, true)
        deploy_storage_account_config          = optional(bool, true)
      }), {})
    }), {})
    devsecops_management_group_policies = optional(object({
      enabled = optional(bool, true)
      create = optional(bool, false)
      name = optional(string, "devsecops")
      config = optional(object({
        deploy_monitoring_config                      = optional(bool, true)
        deploy_network_config                               = optional(bool, true)
        deploy_virtual_machine_config                        = optional(bool, true)
      }), {})
    }), {})
    forensic_management_group_policies = optional(object({
      enabled = optional(bool, false)
      create = optional(bool, false)
      name = optional(string, "forensic")
      config = optional(object({
        deploy_monitoring_config                      = optional(bool, true)
        deploy_network_config                               = optional(bool, true)
        deploy_virtual_machine_config                        = optional(bool, true)
      }), {})
    }), {})
    identity_management_group_policies = optional(object({
      enabled = optional(bool, true)
      create = optional(bool, false)
      name = optional(string, "identity")
      config = optional(object({
        deploy_monitoring_config                      = optional(bool, true)
        deploy_network_config                               = optional(bool, true)
      }), {})
    }), {})
    security_management_group_policies = optional(object({
      enabled = optional(bool, true)
      create = optional(bool, false)
      name = optional(string, "security")
      config = optional(object({
        deploy_monitoring_config                      = optional(bool, true)
        deploy_network_config                               = optional(bool, true)
      }), {})
    }), {})
    transport_management_group_policies = optional(object({
      enabled = optional(bool, true)
      create = optional(bool, false)
      name = optional(string, "transport")
      config = optional(object({
        deploy_monitoring_config                      = optional(bool, true)
        deploy_logging_config                      = optional(bool, true)
        deploy_network_config                               = optional(bool, true)
        deploy_virtual_machine_config                        = optional(bool, true)
      }), {})
    }), {})
    workspace = optional(object({
      create = optional(bool, false)
      name = optional(string, "trpqual-la")
      resource_group = optional(object({
        create = optional(bool, false)
        name = optional(string, "trpqual-mgmt")
      }),{})
      workspace_storage = optional(object({
        create = optional(bool, false)
        name = optional(string, "trpqualeuslawsprodst")
        account_tier = optional(string, "Standard")
        account_replication_type = optional(string, "GRS")
      }),{})
      hub_storage = optional(object({
        create = optional(bool, false)
        name = optional(string, "trpqualeushubprodst")
        account_tier = optional(string, "Standard")
        account_replication_type = optional(string, "GRS")
      }),{})

    }), {})
  })
  description = "Configuration settings for the \"SCCA Policies\" landing zone resources."
  default     = {}
}

variable "log_analytics" {
  type = object({
    
  })
  description = "Configuration settings for the \"SCCA Policies\" landing zone resources."
  default     = {}
}