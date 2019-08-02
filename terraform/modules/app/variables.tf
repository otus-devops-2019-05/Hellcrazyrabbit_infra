variable zone {
  description = "Zone"
  default     = "us-central1-a"
}

variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-img"
}

variable fw_port {
  description = "Firewall allowed port"
  default     = ["9292", "80"]
}

variable fw_allowed_ip {
  description = "Firewall allowed IP"
  default     = ["0.0.0.0/0"]
}

variable vm_type {
  description = "Gcloud machine type"
  default     = "g1-small"
}

variable install_puma {
  description = "Puma service installation"
  default     = "true"
}
