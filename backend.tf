terraform {
  backend "gcs" {
    bucket = "online-boutique-tf-state"
    prefix = "terraform/state"
  }
}