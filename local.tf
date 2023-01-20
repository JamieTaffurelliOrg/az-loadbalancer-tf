locals {
  deployed_backend_address_pools      = [for k in azurerm_lb_backend_address_pool.backend_address_pool : k.name]
  deployed_frontend_ip_configurations = [for k in azurerm_lb.load_balancer.frontend_ip_configuration : k.name]
}
