host_project_id = "" ##project id
network_name = "vpc-php"
subnets = {
   run-snet= {
    ip_cidr_range = "10.128.0.0/21",
    region        = "us-central1"
  },
  sql-snet = {
    ip_cidr_range = "10.128.8.0/21",
    region        = "us-central1"
  }
}

database_version = "MYSQL_5_7"
db_root_password = "root"
db_name = "phplogin"
db_user_name = "test"
db_user_password = "test"

