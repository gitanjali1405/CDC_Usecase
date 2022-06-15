variable "project_name" {
  description = "The project ID where all resources will be launched."
  type = string
}

variable "region" {
  description = "The location region to deploy the Cloud Run services. Note: Be sure to pick a region that supports Cloud Run."
  type        = string
}

variable "zone" {
  description = "The location zone to deploy the Cloud Run services. Note: Be sure to pick a region that supports Cloud Run."
  type        = string
}









