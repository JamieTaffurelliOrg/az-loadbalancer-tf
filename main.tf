resource "azurerm_lb" "load_balancer" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  sku_tier            = "Regional"

  dynamic "frontend_ip_configuration" {
    for_each = { for k in var.frontend_ip_configurations : k.name => k }

    content {
      name                          = frontend_ip_configuration.value["name"]
      subnet_id                     = data.azurerm_subnet.subnets[(frontend_ip_configuration.value["subnet_reference"])].id
      private_ip_address            = frontend_ip_configuration.value["private_ip_address"]
      private_ip_address_allocation = frontend_ip_configuration.value["private_ip_address_allocation"]
      private_ip_address_version    = frontend_ip_configuration.value["private_ip_address_version"]
      zones                         = ["1", "2", "3"]
    }
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  for_each        = { for k in var.backend_address_pools : k => k if k != null }
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = each.key
}

resource "azurerm_lb_backend_address_pool_address" "backend_address_pool_address" {
  for_each                = { for k in var.backend_address_pool_addresses : k.name => k if k != null }
  name                    = each.key
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_address_pool[(each.value["backend_address_pool_reference"])].id
  virtual_network_id      = data.azurerm_virtual_network.virtual_networks[(each.value["virtual_network_reference"])].id
  ip_address              = each.value["private_ip_address"]
}

resource "azurerm_lb_probe" "probe" {
  for_each            = { for k in var.probes : k.name => k if k != null }
  loadbalancer_id     = azurerm_lb.load_balancer.id
  name                = each.key
  port                = each.value["port"]
  protocol            = each.value["protocol"]
  probe_threshold     = each.value["probe_threshold"]
  request_path        = each.value["request_path"]
  interval_in_seconds = each.value["interval_in_seconds"]
  number_of_probes    = each.value["number_of_probes"]
}

resource "azurerm_lb_rule" "rule" {
  for_each                       = { for k in var.rules : k.name => k if k != null }
  loadbalancer_id                = azurerm_lb.load_balancer.id
  name                           = each.key
  protocol                       = each.value["protocol"]
  frontend_port                  = each.value["frontend_port"]
  backend_port                   = each.value["backend_port"]
  frontend_ip_configuration_name = each.value["frontend_ip_configuration_name"]
  backend_address_pool_ids       = [for k in setintersection(local.deployed_backend_address_pools, each.value["backend_address_pool_references"]) : azurerm_lb_backend_address_pool.backend_address_pool[(k)].id]
  probe_id                       = [for k in setintersection(local.deployed_probes, each.value["probe_reference"]) : azurerm_lb_probe.probe[(k)].id]
  enable_floating_ip             = each.value["enable_floating_ip"]
  idle_timeout_in_minutes        = each.value["idle_timeout_in_minutes"]
  load_distribution              = each.value["load_distribution"]
  enable_tcp_reset               = each.value["enable_tcp_reset"]
}
