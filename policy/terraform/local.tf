# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# The following block of locals are used to avoid using
# empty object types in the code
locals {
  empty_list   = []
  empty_map    = tomap({})
  empty_string = ""
}

# The following locals are used to convert provided input
# variables to locals before use elsewhere in the module
locals {
  root_id   = var.root_management_group_id
  root_name = var.root_management_group_display_name
}

locals {
  resource_discovery_mode = var.re_evaluate_compliance == true ? "ReEvaluateCompliance" : "ExistingNonCompliant"
}

# The following locals are used to ensure non-null values
# are assigned to each of the corresponding inputs for
# correct processing in `lookup()` functions.
#
# We also need to ensure that each `???_resources_advanced`
# local is handled as an `object()` rather than `map()` to
# prevent `lookup()` errors when only partially specified
# with attributes of a single type.
#
# This is achieved by merging an `object()` with multiple
# types (`create_object`) to the input from `advanced`.
#
# For more information about this error, see:
# https://github.com/Azure//issues/227#issuecomment-1097623677
locals {
  enforcement_mode_default = {
    enforcement_mode = null
  }
  create_object = {
    # Technically only needs two object types to work.
    add_bool   = true
    add_string = local.empty_string
    add_list   = local.empty_list
    add_map    = local.empty_map
    add_null   = null
  }
  parameter_map_default = {
    parameters = local.empty_map
  }
}

# The following locals are used to define base Azure
# provider paths and resource types
locals {
  provider_path = {
    management_groups = "/providers/Microsoft.Management/managementGroups/"
    role_assignment   = "/providers/Microsoft.Authorization/roleAssignments/"
    rg_resourceId_prefix     = {
      hub = "/subscriptions/${var.subscription_id_hub}/resourceGroups/"     
    }
  }

  resource_types = {
    policy_definition     = "Microsoft.Authorization/policyDefinitions"
    policy_set_definition = "Microsoft.Authorization/policySetDefinitions"
  }
}

# The following locals are used to control time_sleep
# delays between resources to reduce transient errors
# relating to replication delays in Azure
locals {
  create_duration_delay = {
    after_azurerm_policy_assignment     = var.create_duration_delay["azurerm_policy_assignment"]
    after_azurerm_policy_definition     = var.create_duration_delay["azurerm_policy_definition"]
    after_azurerm_policy_set_definition = var.create_duration_delay["azurerm_policy_set_definition"]
  }
  destroy_duration_delay = {
    after_azurerm_policy_assignment     = var.destroy_duration_delay["azurerm_policy_assignment"]
    after_azurerm_policy_definition     = var.destroy_duration_delay["azurerm_policy_definition"]
    after_azurerm_policy_set_definition = var.destroy_duration_delay["azurerm_policy_set_definition"]
  }
}

# The follow locals are used to control non-compliance messages
locals {
  policy_non_compliance_message_enabled                   = var.policy_non_compliance_message_enabled
  policy_non_compliance_message_not_supported_definitions = var.policy_non_compliance_message_not_supported_definitions
  policy_non_compliance_message_default_enabled           = var.policy_non_compliance_message_default_enabled
  policy_non_compliance_message_default                   = var.policy_non_compliance_message_default
  policy_non_compliance_message_enforcement_placeholder   = var.policy_non_compliance_message_enforcement_placeholder
  policy_non_compliance_message_enforced_replacement      = var.policy_non_compliance_message_enforced_replacement
  policy_non_compliance_message_not_enforced_replacement  = var.policy_non_compliance_message_not_enforced_replacement
}

