locals {
  deployed_backend_address_pools = [for k in azurerm_lb_backend_address_pool.backend_address_pool : k.name]
  deployed_probes                = [for k in azurerm_lb_probe.probe : k.name]
}
