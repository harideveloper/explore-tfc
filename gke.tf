module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"

  project_id        = var.gcp_project_id
  name              = var.name
  regional          = false
  region            = var.region
  zones             = [var.zone]
  network           = module.vpc.network_name
  subnetwork        = local.subnet_name
  ip_range_pods     = "${local.subnet_name}-pod-cidr"
  ip_range_services = "${local.subnet_name}-svc1-cidr"
  //default_max_pods_per_node = 64
  service_account = google_service_account.sa.email
  network_policy  = true

  enable_private_endpoint = true
  enable_private_nodes    = true
  master_ipv4_cidr_block  = local.master_ip

  master_authorized_networks = [{
    cidr_block   = "${module.bastion.ip_address}/32"
    display_name = "Bastion Host"
  }]

  database_encryption = [
    {
      "key_name" : module.kms.keys["gke-key"],
      "state" : "ENCRYPTED"
    }
  ]

  node_pools = [
    {
      name         = "primary-node-pool"
      autoscaling  = false
      auto_upgrade = true
      min_count    = local.node_count
      max_count    = local.node_count
      node_count   = local.node_count
      machine_type = local.machine_type
    },
  ]

  #depends_on = [module.vpc, google_service_account.sa, module.bastion]
  depends_on = [module.vpc, google_service_account.sa, module.bastion, module.kms.keys]

}
