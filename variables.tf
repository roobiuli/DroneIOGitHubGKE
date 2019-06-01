variable "Zone" {
    type = "string"
    description = "GCP compute location for GKE and primary node"
}

variable "ClusterName" {
    type = "string"
    description = "GCP GKE name "
}

variable "GkeUsername" {
    type = "string"
    description = "GCP GKE master Auth username"
}

variable "GkePassword" {
    type = "string"
    description = "GCP GKE master Auth password"
}


### DRONE IO Server Configs

variable "GitHubServer" {
    type = "string"
    description = "GitHub Server that DroneIO should integrate with"
}
variable "GitHubClientId" {
    type = "string"
    description = "Github Server generated client id"
}
variable "GitHubClientSecret" {
    type = "string"
    description = "Github Server generated client secret "
}
variable "RpcSecret" {
    type = "string"
    description = "Self Generated secret"
}

