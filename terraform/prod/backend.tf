terraform {
  backend "gcs" {
    bucket = "prismatic-bucket-n1"
    prefix = "prod"
  }
}
