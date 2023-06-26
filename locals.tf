locals {

  // Project APIs
  base_apis = [
    "container.googleapis.com",
    "monitoring.googleapis.com",
    "cloudtrace.googleapis.com",
    "cloudprofiler.googleapis.com",
    "iap.googleapis.com",
    "cloudkms.googleapis.com"
  ]
  memorystore_apis = ["redis.googleapis.com"]

  // GKE Cluster
  cluster_name = "online-boutique" //module.gke.name
  machine_type = "n1-standard-4"   # 1 vCPU; 3.75 GiB
  node_count   = 1

  // Networking
  vpc            = "${var.name}-vpc"
  subnet_name    = "${var.name}-primary-subnet"
  primary_cidr   = "10.0.0.0/16"
  pod_cidr       = "10.1.0.0/16"
  svc1_cidr      = "10.2.0.0/16"
  svc2_cidr      = "10.3.0.0/16"
  pod_2_pod_cidr = "10.1.0.0/16"

  master_ip = "172.16.0.0/28"


  // Bastion host for developers
  bastion_name    = format("%s-bastion", local.cluster_name)
  bastion_zone    = format("%s-a", var.region)
  bastion_machine = "g1-small"


  // KMS
  keyring = "${var.name}-gke-keyring"


}
