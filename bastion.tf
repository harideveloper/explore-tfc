
module "bastion" {
  source  = "terraform-google-modules/bastion-host/google"
  version = "~> 5.0"

  network              = module.vpc.network_name
  subnet               = local.subnet_name
  project              = var.gcp_project_id
  host_project         = var.gcp_project_id
  name                 = local.bastion_name
  zone                 = local.bastion_zone
  image_project        = local.bastion_image
  machine_type         = local.bastion_machine
  startup_script       = templatefile("${path.module}/templates/startup-script.tftpl", {})
  members              = var.bastion_members
  shielded_vm          = "false"
  # service_account_name = google_service_account.bastion_sa.account_id
  service_account_name = "bastion-vm"
  service_account_roles_supplemental = [
    "roles/container.developer"
  ]
  //service_account_email = google_service_account.bastion_sa.email

  # depends_on = [module.vpc, google_service_account.bastion_sa]
  depends_on = [module.vpc]
}


