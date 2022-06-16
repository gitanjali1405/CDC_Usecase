variable "project_name" {}
variable "region" {}
variable "zone" {}

provider "google" {
  project = var.project_name
  region = var.region
  zone = var.zone
}

resource "google_sql_database_instance" "master" {
  name = "master1"
  database_version = "SQL Server 2019 Standard"
  region       = var.region

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_composer_environment" "test" {
  name   = "example-composer-env"
  region = var.region
}
