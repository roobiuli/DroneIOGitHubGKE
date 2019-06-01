provider "kubernetes" {
    host = "${google_container_cluster.DroneIOCluster.endpoint}"
    username = "${var.GkeUsername}"
    password = "${var.GkePassword}"

    client_certificate     = "${base64decode(google_container_cluster.DroneIOCluster.master_auth.0.client_certificate)}"
     client_key            = "${base64decode(google_container_cluster.DroneIOCluster.master_auth.0.client_key)}"
    cluster_ca_certificate = "${base64decode(google_container_cluster.DroneIOCluster.master_auth.0.cluster_ca_certificate)}"
}




#### DroneIO Server deployment 

resource "kubernetes_deployment" "DroneIOServer" {
  metadata {
     name = "droneserver"
     labels {
       app = "DroneServer"
     }
    
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "DroneServer"
      }
    }

    template {
      metadata {
        labels {
          app = "DroneServer"
        }
      }

      spec {
        container {
          image = "drone/drone:1.0.0"
          name  = "droneserver"
        port {
          container_port = 80
        }

        port {
          container_port = 443

        }
          env {
            name = "DRONE_KUBERNETES_ENABLED"
            value = "true"
          }
          env {
            name = "DRONE_KUBERNETES_NAMESPACE"
            value = "default"
          }
          env {
            name = "DRONE_GITHUB_SERVER"
            value = "${var.GitHubServer}"
          }
          env {
            name = "DRONE_GITHUB_CLIENT_ID"
            value = "${var.GitHubClientId}"
          }
          env {
            name = "DRONE_GITHUB_CLIENT_SECRET"
            value = "${var.GitHubClientSecret}"
          }
          env {
            name = "DRONE_RPC_SECRET"
            value = "${var.RpcSecret}"
          }
          env {
            name = "DRONE_SERVER_HOST"
            value = "test.dronetest.test"
          }
          env {
            name = "DRONE_SERVER_PROTO"
            value = "https"
          }
          resources{
            limits{
              cpu    = "0.5"
              memory = "1024Mi"
            }
            requests{
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
 }

 #### Drone IO Service expose 

 resource "kubernetes_service" "DroneIOServer" {
  metadata {
    name = "droneserver"
    labels {
      app  = "DroneServer"
    }
  }

  spec {
    selector {
      app  = "${kubernetes_deployment.DroneIOServer.metadata.0.labels.app}"
      //tier = "frontend"
    }

    type = "LoadBalancer"

    port {
      name = "http"
      port = 80
      target_port = 80
    }
    port {
      name = "https"
      port = 443
      target_port = 443
    }
  }
}