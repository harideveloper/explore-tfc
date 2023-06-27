resource "random_id" "suffix" {
  byte_length = 3
}

module "kms" {
  source          = "terraform-google-modules/kms/google"
  version         = "~> 2.2.1"
  project_id      = var.gcp_project_id
  location        = var.region
  keyring         = "${var.name}-${random_id.suffix.hex}"
  keys            = ["gke-key"]
  prevent_destroy = false
}