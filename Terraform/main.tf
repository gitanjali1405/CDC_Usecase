provider "google" {
  project = "${var.project_name}"
  region = "${var.region}"
  zone = var.zone
}

resource "google_sql_database_instance" "instance" {
  name = "cdc-poc-sqlserver"
  database_version = "SQLSERVER_2019_STANDARD"
  region = "${var.region}"

  settings {
    tier = "db-f1-micro"
  }

}
