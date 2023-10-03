terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "apache_http_server_port_scanning_incident" {
  source    = "./modules/apache_http_server_port_scanning_incident"

  providers = {
    shoreline = shoreline
  }
}