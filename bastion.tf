
module "bastion" {
  source  = "terraform-google-modules/bastion-host/google"
  version = "~> 5.0"

  network        = module.vpc.network_name
  subnet         = local.subnet_name
  project        = var.gcp_project_id
  host_project   = var.gcp_project_id
  name           = local.bastion_name
  zone           = local.bastion_zone
  image_project  = local.bastion_image
  machine_type   = local.bastion_machine
  startup_script = templatefile("${path.module}/templates/vm-startup.tftpl", {})
  members        = var.bastion_members
  shielded_vm    = "false"

  service_account_name               = local.bastion_service_account_name
  service_account_roles_supplemental = local.bastion_additional_roles

  depends_on = [module.vpc]
}


