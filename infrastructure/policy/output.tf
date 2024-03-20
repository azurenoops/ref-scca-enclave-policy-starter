# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

##########
# Outputs 
##########

####################
# General
####################

# get all the generated parameter names so we know what to use during assignment
output "mod_deploy_general_config_root_initiative_parameters" {
  value = keys(module.mod_deploy_general_config_root_initiative.parameters)
}

######################
# Defender for Cloud
######################

# get all the generated parameter names so we know what to use during assignment
output "mod_deploy_defender_root_initiative_parameters" {
  value = keys(module.mod_deploy_defender_root_initiative.parameters)
}

####################
# Monitoring
####################

# get all the generated parameter names so we know what to use during assignment
output "mod_deploy_diagnostic_monitoring_root_initiative_parameters" {
  value = keys(module.mod_deploy_diagnostic_monitoring_root_initiative.parameters)
}

####################
# Cost Management
####################

# get all the generated parameter names so we know what to use during assignment
/* output "mod_deploy_cost_management_config_root_initiative_parameters" {
  value = keys(module.mod_deploy_cost_management_config_root_initiative.parameters)
} */