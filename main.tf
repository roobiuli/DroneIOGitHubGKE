resource "google_container_cluster" "DroneIOCluster" {
  name     = "${var.ClusterName}"
  zone = "${var.Zone}"
  remove_default_node_pool = true
  initial_node_count = 1

  # Setting an empty username and password explicitly disables basic auth
  master_auth {
    username = "${var.GkeUsername}"
    password = "${var.GkePassword}"
  }
}




resource "google_container_node_pool" "primary" {
  name       = "${google_container_cluster.DroneIOCluster.name}-node-pool"
  location   = "${var.Zone}"
  cluster    = "${google_container_cluster.DroneIOCluster.name}"
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
