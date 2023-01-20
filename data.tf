data "azurerm_subnet" "subnets" {
  for_each             = { for k in var.subnets : k.name => k }
  name                 = each.key
  virtual_network_name = each.value["virtual_network_name"]
  resource_group_name  = each.value["resource_group_name"]
}

data "azurerm_virtual_network" "virtual_networks" {
  for_each            = { for k in var.virtual_networks : k.name => k }
  name                = each.key
  resource_group_name = each.value["resource_group_name"]
}

data "azurerm_log_analytics_workspace" "logs" {
  provider            = azurerm.logs
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}
