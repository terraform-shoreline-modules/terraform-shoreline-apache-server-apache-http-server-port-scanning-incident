resource "shoreline_notebook" "apache_http_server_port_scanning_incident" {
  name       = "apache_http_server_port_scanning_incident"
  data       = file("${path.module}/data/apache_http_server_port_scanning_incident.json")
  depends_on = [shoreline_action.invoke_block_ip_range,shoreline_action.invoke_configure_apache_rate_limit]
}

resource "shoreline_file" "block_ip_range" {
  name             = "block_ip_range"
  input_file       = "${path.module}/data/block_ip_range.sh"
  md5              = filemd5("${path.module}/data/block_ip_range.sh")
  description      = "Block the IP address or range that initiated the port scanning activity using a firewall or network security device to prevent further scanning attempts."
  destination_path = "/agent/scripts/block_ip_range.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "configure_apache_rate_limit" {
  name             = "configure_apache_rate_limit"
  input_file       = "${path.module}/data/configure_apache_rate_limit.sh"
  md5              = filemd5("${path.module}/data/configure_apache_rate_limit.sh")
  description      = "Implementing rate limiting in Apache HTTP Server"
  destination_path = "/agent/scripts/configure_apache_rate_limit.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_block_ip_range" {
  name        = "invoke_block_ip_range"
  description = "Block the IP address or range that initiated the port scanning activity using a firewall or network security device to prevent further scanning attempts."
  command     = "`chmod +x /agent/scripts/block_ip_range.sh && /agent/scripts/block_ip_range.sh`"
  params      = []
  file_deps   = ["block_ip_range"]
  enabled     = true
  depends_on  = [shoreline_file.block_ip_range]
}

resource "shoreline_action" "invoke_configure_apache_rate_limit" {
  name        = "invoke_configure_apache_rate_limit"
  description = "Implementing rate limiting in Apache HTTP Server"
  command     = "`chmod +x /agent/scripts/configure_apache_rate_limit.sh && /agent/scripts/configure_apache_rate_limit.sh`"
  params      = []
  file_deps   = ["configure_apache_rate_limit"]
  enabled     = true
  depends_on  = [shoreline_file.configure_apache_rate_limit]
}

