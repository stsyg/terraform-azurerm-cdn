# Generate a random string (consisting of four characters)
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "random" {
  length  = 4
  upper   = false
  special = false
}

# Create resource group
resource "azurerm_resource_group" "websvc" {
  location = var.deploy_location
  name     = var.rg_name
  tags     = var.default_tags
}

# Create Azure Front Door Endpoint profile
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_frontdoor_endpoint
resource "azurerm_cdn_frontdoor_profile" "fdwebsvc" {
  name                = var.fd_endpoint_profile_name
  resource_group_name = azurerm_resource_group.websvc.name
  sku_name            = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "fdwebsvc" {
  name                     = var.fd_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fdwebsvc.id
  tags                     = var.default_tags
}