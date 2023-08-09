
# Subscription Scope Resource Exemption
module "exemption_rg_platform_public_ip" {
  source               = "azurenoops/overlays-policy/azurerm//modules/policyExemption/resourceGroup"
  version              = ">= 1.2.1"
  name                 = "Resource Group Platform Public IP Exemption"
  display_name         = "Exempted"
  description          = "Excludes Resource Group from configuring deny public IP policy"
  scope                = "${local.provider_path.rg_resourceId_prefix.hub}${var.hub_resource_group_name}"
  policy_assignment_id = module.mod_mg_deny_public_ip_platforms.id
}

module "exemption_rg_app1_prod_public_ip" {
  source               = "azurenoops/overlays-policy/azurerm//modules/policyExemption/resourceGroup"
  version              = ">= 1.2.1"
  name                 = "Resource Group App1 Workload Public IP Exemption"
  display_name         = "Exempted"
  description          = "Excludes Resource Group from configuring deny public IP policy"
  scope                = "/subscriptions/${var.subscription_id_app1}/resourceGroups/${var.app1_resource_group_name}"
  policy_assignment_id = module.mod_mg_deny_public_ip_workloads_partners.id
  exemption_category   = "Waiver"
  expires_on           = "2024-07-25"
}

module "exemption_rg_app2_prod_public_ip" {
  source               = "azurenoops/overlays-policy/azurerm//modules/policyExemption/resourceGroup"
  version              = ">= 1.2.1"
  name                 = "Resource Group App2 Workload Public IP Exemption"
  display_name         = "Exempted"
  description          = "Excludes Resource Group from configuring deny public IP policy"
  scope                = "/subscriptions/${var.subscription_id_app2}/resourceGroups/${var.app2_resource_group_name}"
  policy_assignment_id = module.mod_mg_deny_public_ip_workloads_partners.id
  exemption_category   = "Waiver"
  expires_on           = "2024-07-25"
}