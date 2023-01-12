resource "google_sql_database_instance" "master" {
  project             = var.host_project_id
  name                = "${var.host_project_id}-mysql"
  database_version    = var.database_version
  region              = var.region
  deletion_protection = var.deletion_protection
  root_password       = var.db_root_password

  settings {
    tier = var.db_tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc_network.id
    }
  }

  # provisioner "local-exec" {
  #   working_dir = "${path.module}/schema.sql"
  #   command     = "sh load_schema.sh ${var.host_project_id} ${google_sql_database_instance.master.name}"
  # }
}


resource "google_sql_database" "default" {
  count     = var.enable_default_db ? 1 : 0
  name      = var.db_name
  project   = var.host_project_id
  instance  = google_sql_database_instance.master.name
  depends_on = [
    google_sql_database_instance.master
  ]
}

resource "google_sql_user" "default" {
  count    = var.enable_default_user ? 1 : 0
  name     = var.db_user_name
  project  = var.host_project_id
  instance = google_sql_database_instance.master.name
  password = var.db_user_password 

  depends_on = [
    google_sql_database_instance.master
  ]
}