resource "google_compute_network" "vpc_network" {
  project                 = var.host_project_id
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
}

resource "google_compute_subnetwork" "subnet" {
  for_each                = var.subnets
  name                    = "${var.host_project_id}-${each.key}"
  project                 = var.host_project_id
  ip_cidr_range           = each.value.ip_cidr_range
  region                  = each.value.region
  network                 = google_compute_network.vpc_network.id
  private_ip_google_access= var.enable_private_ip_google_access
}

resource "google_compute_global_address" "global_address" {
  name          = "${var.host_project_id}-vpc-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
  project       = var.host_project_id
  depends_on    = [google_compute_network.vpc_network]
}

resource "google_service_networking_connection" "vpcpeerings" {
    network                 = google_compute_network.vpc_network.id
    service                 = "servicenetworking.googleapis.com"
    reserved_peering_ranges = [google_compute_global_address.global_address.name]
    depends_on    = [ google_compute_network.vpc_network]
}

# resource "google_vpc_access_connector" "connector" {
#     project       = var.host_project_id
#     name          = "vpc-connector"
#     subnet {
#     name       = google_compute_subnetwork.subnet["run-snet"].name
#     project_id = var.host_project_id
#   }
#     region        = var.region
#     depends_on    = [google_compute_global_address.global_address, ]
# }


