#vpc_module.tf

########################### CREATE AND CONFIGURE VPC NETWORK ###########################

variable "project_name" {
  type    = string
}

variable "vpc_name" {
  type    = string
}

variable "subnet_cidr" {
  type    = string
}

resource "google_compute_network" "vpc_network" {
  project                 = var.project_name
  name                    = var.vpc_name
  auto_create_subnetworks = false
  mtu                     = 1460

  subnetwork {
    name          = "subnet-gitlab"
    ip_cidr_range = var.subnet_cidr
  }
}

resource "google_compute_network" "vpc_network" {
  project                 = "my-project-name"
  name                    = "vpc-gitlab"
  auto_create_subnetworks = true
  mtu                     = 1460
}

resource "google_compute_firewall" "allow-http" {
  name        = "allow-http"
  network     = google_compute_network.vps_gitlab.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_firewall" "allow-https" {
  name        = "allow-https"
  network     = google_compute_network.vps_gitlab.name
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}

resource "google_compute_firewall" "allow-ssh" {
  name        = "allow-ssh"
  network     = google_compute_network.vps_gitlab.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
