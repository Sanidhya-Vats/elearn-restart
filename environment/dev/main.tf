module "elearn_rg" {
  source = "../../modules/azurerm_resource_group"

  resource_group_name = "${local.name_pattern}-rg" //"elearn-dev-ci-rg"
  location            = local.location
  tags = {
    environment = local.environment
    project     = local.project
  }
}

module "elearn_vnet" {
  source = "../../modules/azurerm_virtual_network"

  virtual_network_name = "${local.name_pattern}-vnet"
  address_space        = ["10.0.0.0/16"]
  location             = local.location
  resource_group_name  = module.elearn_rg.resource_group_name
  tags = {
    environment = local.environment
    project     = local.project
  }
  subnets = {
    subnet1 = {
      name             = "${local.name_pattern}-subnet"
      address_prefixes = ["10.0.0.0/24"]
    }
    subnet2 = {
      name             = "${local.name_pattern}-subnet2"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}

