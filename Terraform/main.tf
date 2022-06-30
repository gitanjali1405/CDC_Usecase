variable "project_name" {}
variable "region" {}
variable "zone" {}

provider "google" {
  project = var.project_name
  region = var.region
  zone = var.zone
}


resource "google_sql_database_instance" "cdc" {
  name = "cdc-poc-sqlserver"
  database_version = "SQLSERVER_2019_STANDARD"
  region = var.region

  settings {
    tier = "db-f1-micro"
      ip_configuration {
        ipv4_enabled    = false
        //private_network = google_compute_network.private_network.id
      }
  }
}
