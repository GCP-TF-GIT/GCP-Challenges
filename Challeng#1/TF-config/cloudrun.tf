resource "google_cloud_run_service" "php" {
  name     = "${var.host_project_id}-php"
  location = var.region
  project  = var.host_project_id

  template {
    spec {
      #service_account_name = google_service_account.runsa.email
      containers {
        image = "${var.region}-docker.pkg.dev/${var.host_project_id}/${var.basename}/php:v1"
        ports {
          container_port = 80
        }
        env {
          name  = "DB_USER"
          value = "root"
        }
        env {
          name  = "DB_PASS"
          value = "${var.db_root_password}"
        }
        env {
          name  = "DB_NAME"
          value = "${var.db_name}"
        }
        env {
          name  = "INSTANCE_UNIX_SOCKET"
          value = "/cloudsql/${google_sql_database_instance.master.connection_name}"
        }

      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"        = "10"
        "run.googleapis.com/cloudsql-instances"   = google_sql_database_instance.master.connection_name
        "run.googleapis.com/client-name"          = "terraform"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
  autogenerate_revision_name = true
  depends_on = [
    google_sql_database_instance.master
  ]
}