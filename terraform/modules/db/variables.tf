variable zone {
  description = "Zone"
  default     = "us-central1-a"
}

variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable db_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-db-img"
}

variable db_fw_port {
  description = "Firewall allowed port"
  default     = ["27017"]
}

variable vm_type {
  description = "Gcloud machine type"
  default     = "g1-small"
}
