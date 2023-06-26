# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
