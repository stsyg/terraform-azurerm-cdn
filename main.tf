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

# Create Azure CDN Profile
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_profile
resource "azurerm_cdn_profile" "cdnwebsvc" {
  name     = var.cdn_endpoint_profile_name
  location = "Global"
  #  location            = azurerm_resource_group.websvc.location
  resource_group_name = azurerm_resource_group.websvc.name
  sku                 = "Standard_Microsoft"
  tags                = var.default_tags
}

# Create Azure CDN Endpoint and CDN Profile
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_endpoint
resource "azurerm_cdn_endpoint" "cdnwebsvc" {
  name     = var.cdn_endpoint_name
  location = "Global"
  #  location            = azurerm_resource_group.websvc.location
  resource_group_name = azurerm_resource_group.websvc.name
  profile_name        = azurerm_cdn_profile.cdnwebsvc.name
  origin_host_header  = var.origin_host_header_name
  tags                = var.default_tags

  # Origin
  origin {
    name      = var.origin_name
    host_name = var.origin_host_name
  }


  # Caching rules
  querystring_caching_behaviour = "UseQueryString"

  # Compression
  is_compression_enabled = true
  content_types_to_compress = [
    "text/plain",
    "text/html",
    "text/css",
    "text/csv",
    "text/js",
    "text/javascript",
    "text/richtext",
    "text/tab-separated-values",
    "text/xml",
    "text/x-script",
    "text/x-component",
    "text/x-java-source",
    "application/javascript",
    "application/json",
    "application/eot",
    "application/font",
    "application/font-sfnt",
    "application/opentype",
    "application/otf",
    "application/pkcs7-mime",
    "application/truetype",
    "application/ttf",
    "application/vnd.ms-fontobject",
    "application/xhtml+xml",
    "application/xml",
    "application/xml+rss",
    "application/x-javascript",
    "application/x-font-opentype",
    "application/x-font-truetype",
    "application/x-font-ttf",
    "application/x-httpd-cgi",
    "application/x-mpegurl",
    "application/x-opentype",
    "application/x-otf",
    "application/x-perl",
    "application/x-ttf",
    "font/eot",
    "font/ttf",
    "font/otf",
    "font/opentype",
    "image/svg+xml"
  ]

  # Rules engine
  global_delivery_rule {
    cache_expiration_action {
      behavior = "Override"
      duration = "00:05:00"
    }
  }

  delivery_rule {
    name  = "blogredirect"
    order = 1

    url_path_condition {
      operator     = "Contains"
      match_values = ["/blog"]
    }
    url_redirect_action {
      redirect_type = "Moved"
      path          = "/photo-locations"
    }
  }
}

# Create Azure CDN Endpoint Custom Domain
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_endpoint_custom_domain

resource "azurerm_cdn_endpoint_custom_domain" "photo38" {
  name            = var.custom_host
  cdn_endpoint_id = azurerm_cdn_endpoint.cdnwebsvc.id
  host_name       = var.custom_host_name

  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}