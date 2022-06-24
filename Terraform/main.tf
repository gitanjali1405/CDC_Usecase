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

resource "google_composer_environment" "cdc" {
  name   = "cdc-poc-composer-env"
  region = var.region

  config {
    node_config {
      disk_size_gb = 30
      zone         = "us-central1-a"
      machine_type = "n1-standard-1"

      //network    = google_compute_network.network.id
      //subnetwork = google_compute_subnetwork.subnetwork.id
      //service_account = scv_account
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

