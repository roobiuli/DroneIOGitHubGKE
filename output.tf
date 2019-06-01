output "client_certificate" {
  value = "${google_container_cluster.DroneIOCluster.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.DroneIOCluster.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.DroneIOCluster.master_auth.0.cluster_ca_certificate}"
}


output "DroneIO Server externalIP" {
  value = "${kubernetes_service.DroneIOServer.load_balancer_ingress.0.ip}"
}