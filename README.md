# DroneIO GKE GitHub
## Description 
Terraform module for setting up Drone.IO Github server on Google Kubernetes Engine 

## Installation
* Get the module
```
terraform get <GITHUBREPO> 
```
Or declare it in code and hit:

```
terraform init
```

* Setting up git Oauth2 credentials in GITHUB

Go to your Github org. 


Profile > Settings > Developer settings > OAuth Apps > New OAuth App


1. Set Application Name
2. Homepage URL (Here you set the endpoint of you future DroneIO server ex: drone.mydomain.com)
3. Set App description
4. Set Authorization callback URL which will be something like done.mydomain.com/login
5. Generate shared secret

```
$ openssl rand -hex 16
bea26a2221fd8090ea38720fc445eca6
```

**_NOTE_**: K8s container will expose port 80 and port 443

## Usage

As any other Terraform module you declare the module and set the appropriate environment variables

DoneIO server must the follwoing env vars. for a functional setup:

* DRONE_KUBERNETES_ENABLED
*Default set to true since the module is used to deploy DroneIO server inside GKE*
* DRONE_GITHUB_SERVER
*Set the hostname of your github server*
* DRONE_GITHUB_CLIENT_ID
*Generated Client ID from GitHub*
* DRONE_GITHUB_CLIENT_SECRET
*Generated Client Secret from GitHub*
* DRONE_RPC_SECRET
*The generated secret*
* DRONE_SERVER_HOST
*Your drone server host*
* DRONE_SERVER_PROTO
*Default set to HTTPS* 
  

#### Terraform module implementation example:
```
module "DroneServer" {
    source = "github.com/roobiuli/DroneIOGitHubGKE"

    Zone = "europe-west1"
    ClusterName = "droneioci"
    GkeUsername = "Mysuperusername"
    GkePassword = "2398473298r67523"
    GitHubServer = "https://mygithubserver.com"
    GitHubClientId = "NOTREAL23472398"
    GitHubClientSecret = "NOTREAL3298472398742323423"
    RpcSecret = "3846723874628376423894623"
}
```



## Diagram 

