resource "cloudfoundry_service" "uaa-db" {
  name = "uaa-db"
  space_id = "${data.cloudfoundry_space.cf.id}"
  service = "${var.cf_service_name}"
  plan = "${var.cf_service_plan}"
}
