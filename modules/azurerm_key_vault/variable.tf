variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "standard"
}

variable "soft_delete_retention_days" {
  type    = number
  default = 90
}

variable "purge_protection_enabled" {
  type    = bool
  default = true
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

variable "network_acls" {
  type = object({
    default_action = string
    bypass         = string
    ip_rules       = list(string)
    subnet_ids     = list(string)
  })
  default = null
}

variable "role_assignments" {
  description = "RBAC role assignments for Key Vault"
  type = map(object({
    role_name   = string
    principal_id = string
  }))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
