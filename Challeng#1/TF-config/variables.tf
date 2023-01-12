variable "host_project_id" {
    description = "project ID where resources are creating"
    type = string  
}

variable "region" {
    description = "Region for resources creation"
    type = string
    default = "us-central1"
}

 variable "gcp_api_services" {
     description = "The list of apis necessary for the project"
     type        = list(string)
     default = [
         "compute.googleapis.com",
         "cloudapis.googleapis.com",
         "vpcaccess.googleapis.com",
         "serviceusage.googleapis.com",
         "servicenetworking.googleapis.com",
         "sql-component.googleapis.com",
         "sqladmin.googleapis.com",
         "storage.googleapis.com",
         "run.googleapis.com",
     ]
 }

variable "network_name" {
    description = "VPC network name"
    type = string    
}

variable "auto_create_subnetworks" {
    description = "create subnetworks default"
    type = bool
    default = false  
}

variable "subnets" {
    description = "Map of subnet definitions (ex. desc = {cidr = 10.10.10.0/24, region = us-central1 } )"
    type        = map(map(string))
}

variable "enable_private_ip_google_access" {
    description = "When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access."
    default     = true
}

variable "google_cloudsql_api" {
  description = "Cloud SQL Admin API will be enabled."
  type        = string
  default     = "sqladmin.googleapis.com"
}

variable "api_disable_dependent_services" {
  description = "API Disable Dependencies Services"
  type        = bool
  default     = false
}

variable "api_disable_on_destroy" {
  description = "API Disable on Destroy Services"
  type        = bool
  default     = false
}

variable "database_version" {
  description = "The database version to use"
  type        = string
}

variable "deletion_protection" {
  description = "Used to block Terraform from deleting a SQL Instance."
  type        = bool
  default     = false
}

variable "db_root_password" {
  description = "The name of the default root password for only requied MS SQL"
  type        = string
  sensitive   = true
  default     = ""
}

variable "db_tier" {
  description = "The tier for the master instance."
  type        = string
  default     = "db-n1-standard-1"
}

variable "activation_policy" {
  description = "The activation policy for the master instance.Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`."
  type        = string
  default     = "ALWAYS"
}

variable "availability_type" {
  description = "The availability type for the master instance.This is only used to set up high availability for the PostgreSQL instance. Can be either `ZONAL` or `REGIONAL`."
  type        = string
  default     = "REGIONAL"
}

variable "disk_autoresize" {
  description = "Configuration to increase storage size."
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "The disk size for the master instance."
  default     = 10
}

variable "disk_type" {
  description = "The disk type for the master instance."
  type        = string
  default     = "PD_SSD"
}

variable "enable_default_db" {
  description = "Enable or disable the creation of the default database"
  type        = bool
  default     = true
}

variable "db_name" {
  description = "The name of the default database to create"
  type        = string
}

variable "db_user_name" {
  description = "The name of the default user"
  type        = string
}

variable "enable_default_user" {
  description = "Enable or disable the creation of the default user"
  type        = bool
  default     = true
}

variable "db_user_password" {
  description = "The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable."
  type        = string
  sensitive   = true
  default     = ""
}

variable "basename" {
  description = "default repo for artifact registry"
  type = string
  default = "teslogin"  
}