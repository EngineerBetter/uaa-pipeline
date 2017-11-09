data "cloudfoundry_organization" "cf" {
  name = "${var.cf_org}"
}

data "cloudfoundry_space" "cf" {
    name = "${var.cf_space}"
    org_id = "${data.cloudfoundry_organization.cf.id}"
}
