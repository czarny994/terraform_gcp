# main.tf

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
  region      = var.REGION
  zone        = var.ZONE
}

module "vpc" {
  source        = "./VPC/vpc_module.tf"  # Update the path to the actual module location
  project_name  = "my-project-name"
  vpc_name      = "vpc-gitlab"
  subnet_cidr   = "10.0.0.0/24"  # Update with your desired CIDR range
}

# Additional resources (VM, firewall rules, etc.) can be added here
