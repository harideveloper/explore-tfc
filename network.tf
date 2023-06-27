

module "vpc" {
  source = "terraform-google-modules/network/google"

  project_id   = var.gcp_project_id
  network_name = local.vpc
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = local.subnet_name
      subnet_ip     = local.primary_cidr
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    "${local.subnet_name}" = [
      {
        range_name    = "${local.subnet_name}-pod-cidr"
        ip_cidr_range = local.pod_cidr
      },
      {
        range_name    = "${local.subnet_name}-svc1-cidr"
        ip_cidr_range = local.svc1_cidr
      },
      {
        range_name    = "${local.subnet_name}-svc2-cidr"
        ip_cidr_range = local.svc2_cidr
      },
    ]
  }

  firewall_rules = [
    {
      name        = "${var.name}-allow-master"
      description = "Allow master connectivity"
      direction   = "INGRESS"
      ranges      = ["172.16.0.0/28"]
      allow = [{
        protocol = "tcp"
        ports    = ["443", "10250"]
      }]
    }
  ]
}


module "cloud-nat" {
  source        = "terraform-google-modules/cloud-nat/google"
  version       = "~> 4.0"
  project_id    = var.gcp_project_id
  region        = var.region
  router        = "${var.name}-router"
  network       = module.vpc.network_name
  create_router = true

  depends_on = [module.vpc]
}
