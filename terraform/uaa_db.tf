resource "cloudfoundry_service" "uaa-db" {
  name = "uaa-db"
  space_id = "${data.cloudfoundry_space.pcfdev.id}"
  service = "p-mysql"
  plan = "512mb"
}
