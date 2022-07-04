provider "google" {
  project = "${var.project_name}"
  region = "${var.region}"
  zone = "${var.zone}"
}


resource "google_sql_database_instance" "cdcsql" {
  name = "cdc-poc-sqlserver"
  database_version = "SQLSERVER_2019_STANDARD"
  region = "${var.region}"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = false
    }
  }
}

resource "google_sql_user" "users" {
    name = "root"
    instance = "${google_sql_database_instance.cdcsql.name}"
    host = "%"
    password = "root"
}

resource "google_composer_environment" "cdc" {
  name   = "cdc-poc-composer-env"
  region = var.region

  config {
    node_config {
      disk_size_gb = 30
      zone         = "${var.zone}"
      machine_type = "n1-standard-1"

      //network    = "cdc-vpcnet-dev"
      //subnetwork = "cdc-us-central-subnet1"
      service_account =  "cdc-service-account-1@di-gcp-351221.iam.gserviceaccount.com"
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