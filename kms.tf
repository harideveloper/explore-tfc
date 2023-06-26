module "kms" {
  source          = "terraform-google-modules/kms/google"
  version         = "~> 2.2.1"
  project_id      = var.gcp_project_id
  location        = var.region
  keyring         = local.keyring
  keys            = ["gke-key"]
  prevent_destroy = false
}