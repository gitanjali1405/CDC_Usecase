variable "project_name" {}
variable "region" {}
variable "zone" {}

provider "google" {
  project = var.project_name
  region = var.region
  zone = var.zone
}

resource "google_sql_database_instance" "cdc-poc" {
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

resource "google_composer_environment" "test" {
  name   = "cdc-poc-composer-env"
  region = var.region

  config {
    node_config {
      zone         = "us-central1-a"
      machine_type = "n1-standard-1"

      //network    = google_compute_network.private_network.id
      //subnetwork = google_compute_subnetwork.private_network.id
      service_account = google_service_account.cdc.name
      tags = ["cdc-poc"]
    }
    database_config {
      machine_type = "db-n1-standard-2"
    }
    web_server_config {
      machine_type = "composer-n1-webserver-2"
    }
  }
}

resource "google_service_account" "cdc" {
account_id   = "cdc-service-account-1"
}