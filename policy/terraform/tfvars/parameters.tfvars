# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# This is a sample configuration file for the MPE Landing Zone
# This file is used to configure the MPE Landing Zone.  
# It is used to set the default values for the variables used in the MPE Landing Zone.  The values in this file can be overridden by setting the same variable in the terraform.tfvars file.

# Policy Configuration

// Subscription IDs are sensitive and should be set on the terraform command-line. Shown here for ease of testing
subscription_id_hub  = "<<Hub Subscription Id>>"
subscription_id_app1 = "<<App1 Subscription Id>>"
subscription_id_app2 = "<<App2 Subscription Id>>"

hub_resource_group_name  = "anoa-eus-hub-core-test-rg"
app1_resource_group_name = "anoa-app1-eus-prod-rg"
app2_resource_group_name = "anoa-app2-eus-prod-rg"

securityContactsEmail = "yourAdmin@yourorg.onmicrosoft.us"

# The policy definition id for the policy definition to be assigned to the subscription.  This policy definition id can be obtained from the Azure Policy portal.

root_management_group_id           = "anoa" # the root management group id for this subscription
root_management_group_display_name = "anoa" # the root management group display name for this subscription

skip_remediation       = false # set to true to skip remediation of existing resources
skip_role_assignment   = false # set to true to skip role assignment
re_evaluate_compliance = false # set to true to re-evaluate compliance

policy_non_compliance_message_enabled         = true # set to true to enable the policy non-compliance message
policy_non_compliance_message_default_enabled = true # set to true to enable the policy non-compliance message by default
