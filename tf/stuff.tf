provider "cloudfoundry" {
  api_endpoint = "https://api.local.pcfdev.io"
  username = "admin"
  password = "admin"
  skip_ssl_validation = true
}

data "cloudfoundry_organization" "pcfdev" {
  name = "pcfdev-org"
}

data "cloudfoundry_space" "pcfdev" {
    name = "pcfdev-space"
    org_id = "${cloudfoundry_organization.pcfdev.id}"
}

resource "cloudfoundry_service" "uaa-db" {
  name = "uaa-db"
  space_id = "${cloudfoundry_space.pcfdev.id}"
  service = "p-mysql"
  plan = "512mb"
}