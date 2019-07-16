variable project {
  description = "Project ID"
}

variable region {
  description = "Region"

  # Значение по умолчанию
  default = "us-central1"
}

variable zone {
  description = "Zone"
  default     = "us-central1-a"
}

variable count {
  description = "Instances count"
  default     = "1"
}

variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable disk_image {
  # Описание переменной
  description = "Disk image"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-img"
}

variable db_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-db-img"
}
