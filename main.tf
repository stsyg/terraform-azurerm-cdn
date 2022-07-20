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

  tags = var.default_tags
}
