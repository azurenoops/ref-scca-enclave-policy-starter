
# Subscription Scope Resource Exemption
module "exemption_rg_platform_public_ip" {
  source               = "azurenoops/overlays-policy/azurerm//modules/policyExemption/resourceGroup"
  version              = ">= 1.2.1"
  name                 = "Resource Group Platform Public IP Exemption"
  display_name         = "Exempted"
  description          = "Excludes Resource Group from configuring deny public IP policy"
  scope                = "/subscriptions/${var.subscription_id_hub}/resourceGroups/ampe-eus-hub-core-prod-rg"
  policy_assignment_id = module.mod_mg_deny_public_ip_platforms.id
}

module "exemption_rg_gsa_dev_public_ip" {
  source               = "azurenoops/overlays-policy/azurerm//modules/policyExemption/resourceGroup"
  version              = ">= 1.2.1"
  name                 = "Resource Group GSA Workload Public IP Exemption"
  display_name         = "Exempted"
  description          = "Excludes Resource Group from configuring deny public IP policy"
  scope                = "/subscriptions/${var.subscription_id_gsa_dev}/resourceGroups/ampe-gsa-eus-dev-rg"
  policy_assignment_id = module.mod_mg_deny_public_ip_workloads_partners.id
  exemption_category   = "Waiver"
  expires_on           = "2023-07-25"
}

module "exemption_rg_gsa_prod_public_ip" {
  source               = "azurenoops/overlays-policy/azurerm//modules/policyExemption/resourceGroup"
  version              = ">= 1.2.1"
  name                 = "Resource Group GSA Workload Public IP Exemption"
  display_name         = "Exempted"
  description          = "Excludes Resource Group from configuring deny public IP policy"
  scope                = "/subscriptions/${var.subscription_id_gsa_prod}/resourceGroups/ampe-gsa-eus-prod-rg"
  policy_assignment_id = module.mod_mg_deny_public_ip_workloads_partners.id
  exemption_category   = "Waiver"
  expires_on           = "2023-07-25"
}