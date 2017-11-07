data "cloudfoundry_organization" "pcfdev" {
  name = "pcfdev-org"
}

data "cloudfoundry_space" "pcfdev" {
    name = "pcfdev-space"
    org_id = "${data.cloudfoundry_organization.pcfdev.id}"
}
