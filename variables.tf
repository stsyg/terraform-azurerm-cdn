variable "deploy_location" {
  type        = string
  default     = "canadacentral"
  description = "The Azure Region in which all resources in this example should be created."
}

variable "rg_name" {
  type        = string
  default     = "webservices-rg"
  description = "Name of the Resource group in which to deploy Azure resources"
}

variable "default_tags" {
  type = map
  description = "Map default tags"
}