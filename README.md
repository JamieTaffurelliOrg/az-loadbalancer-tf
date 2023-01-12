# az-loadbalancer-tf
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.20 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.load_balancer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.backend_address_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_backend_address_pool_address.backend_address_pool_address](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool_address) | resource |
| [azurerm_lb_probe.probe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.rule](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule) | resource |
| [azurerm_subnet.subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.virtual_networks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_address_pool_addresses"></a> [backend\_address\_pool\_addresses](#input\_backend\_address\_pool\_addresses) | Addresses to deploy to backend address pools | <pre>list(object(<br>    {<br>      name                           = string<br>      backend_address_pool_reference = string<br>      virtual_network_reference      = string<br>      ip_address                     = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_backend_address_pools"></a> [backend\_address\_pools](#input\_backend\_address\_pools) | Backend address pools to deploy to the load balancer | `list(string)` | `[]` | no |
| <a name="input_frontend_ip_configurations"></a> [frontend\_ip\_configurations](#input\_frontend\_ip\_configurations) | Front end IP configurations to deploy to the load balancer, only internal supported | <pre>list(object(<br>    {<br>      name                          = string<br>      subnet_reference              = string<br>      private_ip_address            = optional(string)<br>      private_ip_address_allocation = optional(string, "Static")<br>      private_ip_address_version    = optional(string, "IPv4")<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name) | Name of the Load Balancer | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the Load Balancer | `string` | n/a | yes |
| <a name="input_probes"></a> [probes](#input\_probes) | Probes to deploy to Load Balancer | <pre>list(object(<br>    {<br>      name                = string<br>      port                = number<br>      protocol            = string<br>      probe_threshold     = optional(number, 1)<br>      request_path        = optional(string)<br>      interval_in_seconds = optional(number, 5)<br>      number_of_probes    = optional(number, 2)<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group name to deploy to | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | Rules to deploy to Load Balancer | <pre>list(object(<br>    {<br>      name                            = string<br>      protocol                        = string<br>      frontend_port                   = number<br>      backend_port                    = number<br>      frontend_ip_configuration_name  = string<br>      backend_address_pool_references = list(string)<br>      probe_reference                 = string<br>      enable_floating_ip              = optional(bool, false)<br>      idle_timeout_in_minutes         = optional(number, 4)<br>      load_distribution               = optional(string, "None")<br>      enable_tcp_reset                = optional(bool, false)<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets to add to backend address pools | <pre>list(object(<br>    {<br>      name                 = string<br>      virtual_network_name = string<br>      resource_group_name  = string<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply | `map(string)` | n/a | yes |
| <a name="input_virtual_networks"></a> [virtual\_networks](#input\_virtual\_networks) | Virtual networks to add to backend address pool addresses | <pre>list(object(<br>    {<br>      name                = string<br>      resource_group_name = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_address_pool_addresses"></a> [backend\_address\_pool\_addresses](#output\_backend\_address\_pool\_addresses) | The backend address pool addresses deployed to the Load Balancer |
| <a name="output_backend_address_pools"></a> [backend\_address\_pools](#output\_backend\_address\_pools) | The backend address pools deployed to the Load Balancer |
| <a name="output_load_balancer"></a> [load\_balancer](#output\_load\_balancer) | Resource ID of the Load Balancer |
| <a name="output_probes"></a> [probes](#output\_probes) | The probes deployed to the Load Balancer |
| <a name="output_rules"></a> [rules](#output\_rules) | The rules deployed to the Load Balancer |
<!-- END_TF_DOCS -->
