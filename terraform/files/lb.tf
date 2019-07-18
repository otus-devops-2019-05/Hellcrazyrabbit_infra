resource "google_compute_instance_group" "reddit-cluster" {
  name        = "reddit-cluster"
  description = "Reddit-app OTUS cluster"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  named_port {
    name = "http"
    port = "9292"
  }

  zone = "${var.zone}"
}

resource "google_compute_target_tcp_proxy" "reddit-ttcp-proxy" {
  name            = "reddit-ttcp-proxy"
  backend_service = "${google_compute_backend_service.lb.self_link}"
}

resource "google_compute_global_address" "lb-ip" {
  name = "lb-ip"
}

resource "google_compute_global_forwarding_rule" "lb-fwd-reddit" {
  name       = "lb-fwd-reddit"
  port_range = "443"
  ip_address = "${google_compute_global_address.lb-ip.address}"
  target     = "${google_compute_target_tcp_proxy.reddit-ttcp-proxy.self_link}"
}

resource "google_compute_backend_service" "lb" {
  name             = "lb"
  description      = "backend-lb"
  protocol         = "TCP"
  timeout_sec      = 10
  session_affinity = "NONE"
  health_checks    = ["${google_compute_health_check.reddit-track.self_link}"]

  backend {
    group = "${google_compute_instance_group.reddit-cluster.self_link}"
  }
}

resource "google_compute_health_check" "reddit-track" {
  name               = "reddit-track"
  check_interval_sec = 5
  timeout_sec        = 5

  tcp_health_check {
    port = "9292"
  }
}
