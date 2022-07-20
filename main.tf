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

# Create Azure CDN Endpoint and CDN Profile
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_endpoint
resource "azurerm_cdn_profile" "cdnwebsvc" {
  name                = var.cdn_endpoint_profile_name
  location            = azurerm_resource_group.websvc.location
  resource_group_name = azurerm_resource_group.websvc.name
  sku                 = "Standard_Microsoft"
  tags                = var.default_tags
}

resource "azurerm_cdn_endpoint" "cdnwebsvc" {
  name                = var.cdn_endpoint_name
  location            = azurerm_resource_group.websvc.location
  resource_group_name = azurerm_resource_group.websvc.name
  profile_name        = azurerm_cdn_profile.cdnwebsvc.name
  tags                = var.default_tags

  origin {
    name      = "adobe-portfolio"
    host_name = "www.contoso.com" # sergiy.myportfolio.com
  }

  is_compression_enabled = true

  content_types_to_compress = [
    "text/plain",
    "text/html",
    "text/css",
    "text/javascript",
    "application/x-javascript",
    "application/javascript",
    "application/json",
    "application/xml"
  ]
}