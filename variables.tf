variable "deploy_location" {
  type        = string
  description = "The Azure Region in which all resources in this example should be created."
}

variable "rg_name" {
  type        = string
  description = "Name of the Resource group in which to deploy Azure resources"
}

variable "default_tags" {
  type        = map(any)
  description = "Map default tags"
}

variable "cdn_endpoint_profile_name" {
  type        = string
  description = "Name of the CDN Endpoint profile"
}

variable "cdn_endpoint_name" {
  type        = string
  description = "Name of the CDN Endpoint"
}
