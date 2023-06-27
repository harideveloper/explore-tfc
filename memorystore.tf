# Create the Memorystore (redis) instance
resource "google_redis_instance" "redis-cart" {
  name           = "redis-cart"
  memory_size_gb = 1
  region         = var.region
  count          = var.memorystore ? 1 : 0

  redis_version = "REDIS_6_X"
  project       = var.gcp_project_id

  depends_on = [
    module.enable_google_apis
  ]
}

#Edit contents of Memorystore kustomization.yaml file to target new Memorystore (redis) instance
resource "null_resource" "kustomization-update" {

  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = "sed -i \"s/REDIS_CONNECTION_STRING/${google_redis_instance.redis-cart[0].host}:${google_redis_instance.redis-cart[0].port}/g\" ../kustomize/components/memorystore/kustomization.yaml"
  }
  count = var.memorystore ? 1 : 0

  depends_on = [
    resource.google_redis_instance.redis-cart
  ]
}
