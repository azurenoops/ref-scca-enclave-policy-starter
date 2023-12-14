# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# This is a sample configuration file for the MPE Landing Zone Policy Starter.
# This file is used to configure the MPE Landing Zone.  
# It is used to set the default values for the variables used in the MPE Landing Zone.  The values in this file can be overridden by setting the same variable in the terraform.tfvars file.

###########################
## Global Configuration  ##
###########################

# The prefixes to use for all resources in this deployment
org_name           = "anoa"   # This Prefix will be used on most deployed resources.  10 Characters max.
deploy_environment = "dev"    # dev | test | prod
environment        = "public" # public | usgovernment

# The default region to deploy to
default_location = "eastus"

#####################################
# Management Groups Configuration  ##
#####################################

root_management_group_id           = "anoa" # the root management group id for this subscription
root_management_group_display_name = "anoa" # the root management group display name for this subscription

##########################
# Policy Configuration  ##
##########################

# The policy definition id for the policy definition to be assigned to the subscription.  This policy definition id can be obtained from the Azure Policy portal.

skip_remediation       = false # set to true to skip remediation of existing resources
skip_role_assignment   = false # set to true to skip role assignment
re_evaluate_compliance = false # set to true to re-evaluate compliance

policy_non_compliance_message_enabled         = true # set to true to enable the policy non-compliance message
policy_non_compliance_message_default_enabled = true # set to true to enable the policy non-compliance message by default
