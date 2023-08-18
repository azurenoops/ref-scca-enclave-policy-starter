
/*
SUMMARY: Module to deploy Policy Definitions for Azure Policy in Partner Environments
DESCRIPTION: The following components will be options in this deployment
             * Policy Definitions
AUTHOR/S: jspinella
*/

###################################################
### Policy Initiative Definitions Configuations ###
###################################################

#####################################################
# Monitoring: Resource & Activity Log Forwarders  ###
#####################################################
module "mod_platform_diagnostics_initiative" {
  depends_on = [
    module.mod_deploy_resource_diagnostic_setting
  ]
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = ">= 1.2.1"
  initiative_name         = "platform_diagnostics_initiative"
  initiative_display_name = "[Platform]: Diagnostics Settings Policy Initiative"
  initiative_description  = "Collection of policies that deploy resource and activity log forwarders to logging core resources"
  initiative_category     = "Monitoring"
  merge_effects           = false # will not merge "effect" parameters
  management_group_id     = data.azurerm_management_group.root.id

  # Populate member_definitions with a for loop (not explicit)
  member_definitions = [for mon in module.mod_deploy_resource_diagnostic_setting : mon.definition]
}

##################
# Security Center
##################
module "mod_configure_asc_initiative" {
  source                  = "azurenoops/overlays-policy/azurerm//modules/policyInitiative"
  version                 = ">= 1.2.1"
  initiative_name         = "configure_asc_initiative"
  initiative_display_name = "[Security]: Configure Azure Security Center"
  initiative_description  = "Deploys and configures Azure Security Center settings and defines exports"
  initiative_category     = "Security Center"
  management_group_id     = data.azurerm_management_group.root.id

  # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.mod_configure_asc["auto_enroll_subscriptions"].definition,
    module.mod_configure_asc["auto_provision_log_analytics_agent_custom_workspace"].definition,
    module.mod_configure_asc["auto_set_contact_details"].definition,
    module.mod_configure_asc["export_asc_alerts_and_recommendations_to_eventhub"].definition,
    module.mod_configure_asc["export_asc_alerts_and_recommendations_to_log_analytics"].definition,
  ]
}
