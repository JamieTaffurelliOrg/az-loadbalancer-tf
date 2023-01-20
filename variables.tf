variable "resource_group_name" {
  type        = string
  description = "Resource Group name to deploy to"
}

variable "location" {
  type        = string
  description = "Location of the Load Balancer"
}

variable "load_balancer_name" {
  type        = string
  description = "Name of the Load Balancer"
}

variable "subnets" {
  type = list(object(
    {
      name                 = string
      virtual_network_name = string
      resource_group_name  = string
  }))
  description = "Subnets to add to backend address pools"
}

variable "virtual_networks" {
  type = list(object(
    {
      name                = string
      resource_group_name = string
  }))
  description = "Virtual networks to add to backend address pool addresses"
}

variable "frontend_ip_configurations" {
  type = list(object(
    {
      name                          = string
      subnet_reference              = string
      private_ip_address            = optional(string)
      private_ip_address_allocation = optional(string, "Static")
      private_ip_address_version    = optional(string, "IPv4")
    }
  ))
  default     = []
  description = "Front end IP configurations to deploy to the load balancer, only internal supported"
}

variable "backend_address_pools" {
  type        = list(string)
  default     = []
  description = "Backend address pools to deploy to the load balancer"
}

variable "backend_address_pool_addresses" {
  type = list(object(
    {
      name                           = string
      backend_address_pool_reference = string
      virtual_network_reference      = string
      private_ip_address             = string
    }
  ))
  default     = []
  description = "Addresses to deploy to backend address pools"
}

variable "probes" {
  type = list(object(
    {
      name                = string
      port                = number
      protocol            = string
      probe_threshold     = optional(number, 1)
      request_path        = optional(string)
      interval_in_seconds = optional(number, 5)
      number_of_probes    = optional(number, 2)
    }
  ))
  default     = []
  description = "Probes to deploy to Load Balancer"
}

variable "rules" {
  type = list(object(
    {
      name                            = string
      protocol                        = string
      frontend_port                   = number
      backend_port                    = number
      frontend_ip_configuration_name  = string
      backend_address_pool_references = list(string)
      probe_reference                 = string
      enable_floating_ip              = optional(bool, false)
      idle_timeout_in_minutes         = optional(number, 4)
      load_distribution               = optional(string, "Default")
      enable_tcp_reset                = optional(bool, false)
    }
  ))
  default     = []
  description = "Rules to deploy to Load Balancer"
}

variable "private_link_services" {
  type = list(object(
    {
      name                                 = string
      auto_approval_subscription_ids       = optional(list(string))
      visibility_subscription_ids          = optional(list(string))
      frontend_ip_configuration_references = list(string)
      enable_proxy_protocol                = optional(bool, false)
      fqdns                                = optional(list(string))
      nat_ip_configurations = list(object({
        name                       = string
        private_ip_address         = string
        private_ip_address_version = optional(string, "IPv4")
        subnet_reference           = string
        primary                    = bool
      }))
    }
  ))
  default     = []
  description = "Private link services to NAT to load balancer front ends"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
}
