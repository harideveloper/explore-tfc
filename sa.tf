resource "google_service_account" "sa" {
  account_id   = "${var.name}-sa"
  display_name = "Customer GKE Service Account for Boutique App"
}

resource "google_project_iam_member" "gke_log_writer" {
  project = var.gcp_project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "gke_monitoring_viewer" {
  project = var.gcp_project_id
  role    = "roles/monitoring.viewer"
  member  = "serviceAccount:${google_service_account.sa.email}"
}


resource "google_project_iam_member" "gke_metric_writer" {
  project = var.gcp_project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "gke_metadata_writer" {
  project = var.gcp_project_id
  role    = "roles/stackdriver.resourceMetadata.writer"
  member  = "serviceAccount:${google_service_account.sa.email}"
}


# resource "google_project_iam_member" "gke_kms_decrypter" {
#   project = var.gcp_project_id
#   role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
#   member  = "serviceAccount:${google_service_account.sa.email}"
# }

resource "google_project_iam_member" "gke_kms_encrypter" {
  project = var.gcp_project_id
  role    = "roles/cloudkms.cryptoKeyEncrypter"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "gke_kms_decrypter" {
  project = var.gcp_project_id
  role    = "roles/cloudkms.cryptoKeyDecrypter"
  member  = "serviceAccount:${google_service_account.sa.email}"
}



// Bastion host

# resource "google_service_account" "bastion_sa" {
#   account_id   = "${var.name}-bastion-sa"
#   display_name = "Customer Service Account for Boutique Admin Tasks through Jump VMs"
# }

# resource "google_project_iam_member" "bastion_reader" {
#   project = var.gcp_project_id
#   role    = "roles/container.developer"
#   member  = "serviceAccount:${google_service_account.bastion_sa.email}"
# }




