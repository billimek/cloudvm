provider "google" {
#   credentials = file(var.credentials)
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "vm_instance" {
  name         = "cloud"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network       = "default"
  }
  tags = ["cloud-vm"]
}

resource "google_compute_router" "router" {
    name    = "router-nat-${var.region}-${var.project}"
    region  = var.region
    network = "default"
    bgp {
        asn = 64514
    }
}

resource "google_compute_router_nat" "simple-nat" {
  name                               = "nat-${var.region}-${var.project}"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_firewall" "allow-ssh-from-iap" {
  name    = "allow-ssh-from-iap"
  network = "default"
  source_ranges = ["35.235.240.0/20"]
  target_tags = ["cloud-vm"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
