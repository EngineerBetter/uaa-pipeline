resource "cloudfoundry_service" "uaa-db" {
  name = "uaa-db"
  space_id = "${data.cloudfoundry_space.cf.id}"
  service = "p-mysql"
  plan = "512mb"
}
