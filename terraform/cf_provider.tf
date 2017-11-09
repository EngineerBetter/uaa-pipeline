provider "cloudfoundry" {
  api_endpoint = "${var.cf_api}"
  username = "${var.cf_username}"
  password = "${var.cf_password}"
  skip_ssl_validation = true
}
