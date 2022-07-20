default_tags = {
  environment = "Dev"
  app         = "Web Services resources"
  provisioner = "Terraform"
}

deploy_location           = "canadacentral"
rg_name                   = "webservices-rg"
cdn_endpoint_profile_name = "mywebsitecdn-demo"
cdn_endpoint_name         = "the38photo-demo"
origin_host_header_name   = "sergiy.myportfolio.com"
origin_name               = "adobe-portfolio"
origin_host_name          = "sergiy.myportfolio.com"
custom_host_name          = "www.the38photo.com"
custom_host               = "the38photo"