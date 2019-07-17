terraform {
  backend "gcs" {
    bucket = "prismatic-bucket-n2"
    prefix = "stage"
  }
}
