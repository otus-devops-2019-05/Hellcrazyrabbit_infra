provider "google" {
  version     = "2.0.0"
  project     = "${var.project}"
  region      = "${var.region}"
  credentials = "${file("/home/sysadmin/robot_acc.json")}"
}

module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.1.1"

  # Имена поменяйте на другие
  name = ["prismatic-bucket-n1", "prismatic-bucket-n2"]
}

output storage-bucket_url {
  value = "${module.storage-bucket.url}"
}
