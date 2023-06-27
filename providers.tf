terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.69.1"
    }
  }
}

provider "google" {
  #access_token	= data.google_service_account_access_token.default.access_token
  project = var.gcp_project_id
  region  = var.region
}

# provider "google" {
#  alias = "impersonation"
#  scopes = [
#    "https://www.googleapis.com/auth/cloud-platform",
#    "https://www.googleapis.com/auth/userinfo.email",
#  ]
# }



# data "google_service_account_access_token" "default" {
#  provider               	= google.impersonation
#  target_service_account 	= local.terraform_service_account
#  scopes                 	= ["userinfo-email", "cloud-platform"]
#  lifetime               	= "1200s"
# }

# locals {
#  terraform_service_account = "tfe-test@dynamic-sanctum-390913.iam.gserviceaccount.com"
# }
