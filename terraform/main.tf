terraform {
  # Версия terraform
  required_version = ">=0.11,<12"
}

provider "google" {
  # Версия провайдера
  version     = "2.0.0"
  credentials = "${file("/home/sysadmin/robot_acc.json")}"

  # ID проекта
  project = "${var.project}"
  region  = "us-central1"
}
