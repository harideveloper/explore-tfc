terraform {
  backend "gcs" {
    bucket  = "online-boutique-tf-state"
    prefix  = "terraform/state"
    #impersonate_service_account = "gitlab-runner-service-account@sandbox-db-enablers.iam.gserviceaccount.com"
 }
}