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
  type        = map(any)
  description = "Map default tags"
}

variable "fd_endpoint_profile_name" {
  type        = string
  default     = "the38photo"
  description = "Name of the Front Door Endpoint profile"
}

variable "fd_endpoint_name" {
  type        = string
  default     = "mywebsitecdn"
  description = "Name of the Front Door Endpoint"
}
