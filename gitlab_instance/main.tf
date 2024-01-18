# Select Region and zoon
# Create VPC network for Gitlab
# Create VM for Gitlab
# Install packages of VMs

variable "REGION" {
  type    = string
  default = "europe-central2"
}

variable "ZONE" {
  type    = string
  default = "europe-central2-a"
}

provider "google" {
  credentials = file("key/terraform_account.json")
  region  = var.REGION
  zone    = var.ZONE
}

########################### CREATE AND CONFIGURE VPC NETWORK ###########################

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
########################### CREATE VM ###########################
