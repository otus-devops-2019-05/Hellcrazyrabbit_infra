# vpc.tf
resource "google_compute_firewall" "firewall_ssh" {
  name    = "default-allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = "${var.ssh_port}"
  }

  source_ranges = "${var.source_ranges}"
}
