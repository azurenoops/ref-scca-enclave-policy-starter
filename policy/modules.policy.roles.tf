# The following module is used to generate the Role
# Assignments for Policy Assignments as needed.
# This was implemented to fix issue:
# https://github.com/Azure//issues/266
/* module "role_assignments_for_policy" {
  source = "./modules/role_assignments_for_policy"

  # Mandatory resource attributes
  policy_assignment_id = "00000000-0000-0000-0000-000000000000"
  scope_id             = data.azurerm_management_group.root.id
  principal_id         = "00000000-0000-0000-0000-000000000000"
  role_definition_ids  = []

  # Optional resource attributes
  additional_scope_ids = local.empty_list

  # Set explicit dependency on Management Group, Policy Definition, Policy Set Definition, and Policy Assignment deployments
  depends_on = [
    time_sleep.after_azurerm_policy_definition,
    time_sleep.after_azurerm_policy_set_definition,
    time_sleep.after_azurerm_policy_assignment,
    azurerm_role_assignment.policy_assignment,
  ]

}

# The following resource is left to help manage the
# upgrade to using module.role_assignments_for_policy
# To be removed in `v2.0.0`
resource "azurerm_role_assignment" "policy_assignment" {
  for_each = local.empty_map

  # Mandatory resource attributes
  name         = basename(each.key)
  scope        = each.value.scope_id
  principal_id = each.value.principal_id

} */
