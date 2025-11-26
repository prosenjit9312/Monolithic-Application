resource "azurerm_policy_definition" "policy" {
  for_each = var.policies

  name         = each.value.name
  policy_type  = each.value.policy_type
  mode         = each.value.mode
  display_name = each.value.display_name

  metadata = jsonencode({
    category = each.value.category
  })

  policy_rule = jsonencode(each.value.policy_rule)
}

# Policy Assignment
resource "azurerm_policy_assignment" "assignment" {
  for_each = var.policies

  name                 = "${each.value.name}-assignment"
  scope                = each.value.scope
  policy_definition_id = azurerm_policy_definition.policy[each.key].id
  description          = "Assignment for ${each.value.display_name}"
  display_name         = "${each.value.display_name} Assignment"
  enforcement_mode     = each.value.enforcement_mode
}
