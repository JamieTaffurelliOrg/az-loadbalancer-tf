output "load_balancer" {
  value       = azurerm_lb.load_balancer
  description = "Resource ID of the Load Balancer"
}

output "backend_address_pools" {
  value       = { for k, v in azurerm_lb_backend_address_pool.backend_address_pool : k => v }
  description = "The backend address pools deployed to the Load Balancer"
}

output "backend_address_pool_addresses" {
  value       = { for k, v in azurerm_lb_backend_address_pool_address.backend_address_pool_address : k => v }
  description = "The backend address pool addresses deployed to the Load Balancer"
}

output "probes" {
  value       = { for k, v in azurerm_lb_probe.probe : k => v }
  description = "The probes deployed to the Load Balancer"
}

output "rules" {
  value       = { for k, v in azurerm_lb_rule.rule : k => v }
  description = "The rules deployed to the Load Balancer"
}
