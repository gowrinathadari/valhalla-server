# Valhalla Demo App

![valhalla_screenshot](https://user-images.githubusercontent.com/10322094/144841673-18ec0772-129d-443e-a040-5172480b0f92.png)

This is the ReactJS demo web app running on https://valhalla.openstreetmap.de. It provides routing and isochrones with a magnitude of options and makes requests to [Valhalla](https://github.com/valhalla/valhalla), an open source routing engine and accompanying libraries for use with OpenStreetMap data.

1.1. AWS Setup using Terraform
* Created Entire INfrastructure Using Terraform scrips for following Infra
* VPC, EC2, SECURITY GROUPS, NAT GATEWAY,ECR, IAM ROLES, S3 BUCKETS
* Kept "terraform.tfstate" file in remote backeend that is "s3" Bucket and locked with dynabodvb table
* Those terraform folder has been adde in this repository
2. Docker Configuration
  * created AWS ECR repository to store Docker Images
  * created docker image from dockerfile
  * pushed the docker image to AWS ECR REPO : 853845817090.dkr.ecr.ap-south-1.amazonaws.com/valhalla:latest
 3.Kubernetes Deployment
   * created kuberenets cluster on aws infrastructure using KOPS
   * sudo yum install -y unzip
#Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

#Setup Kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl

#setup kops

curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

#Generating SSH Gen key
ssh-keygen

kops create cluster --name=valhalla.k8s.local --state=s3://valhalla-k8-storage --zones=ap-south-1a,ap-south-1b,ap-south-1c --node-count=3 --node-size=t2.medium --master-count=3 --master-size=t3.medium --yes
* created Deployment.yaml file to deploy pods with replicates, adn servrices inclusding name spaces ,
* for High Availabilty of Infrastructure created 3-Master Nodes Aand 2 Worker nodes in ap-south-1 Zone
* Implemented HPA for High Availbility based on Resource utilisation & Selfhealing

. 4.Load Balancing and Scalability
    * Application can be accecible only via Loadbalancer only http://ae97462dbdfee47708395e8da219cfc3-1506760141.ap-south-1.elb.amazonaws.com/ or you can access using http://mynewlms.in/
   5.Networking and Security 
   * all pods,Deployments, svs are in particular name space they are isolated Logically
   * Used Load Balancer to access application instead of Noeport
   * To secure the Kubernetes Cluster Implemented RBAC Policies
     
