provider "google" {
  project     = "aesthetic-petal-371419"
  region      = "us-central1"
  credentials = "${file("creds.json")}"
}

 resource "google_project_service" "api" {
     for_each                   = toset(var.gcp_api_services)
     project                    = var.host_project_id
     service                    = each.key
     disable_on_destroy         = false
 }
