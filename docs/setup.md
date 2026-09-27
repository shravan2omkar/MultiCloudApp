# Setup Guide

## Prerequisites
- Windows 10/11
- PowerShell
- Docker Desktop
- AWS CLI
- Terraform
- kubectl
- Helm

## Steps
1. **Provision EKS Cluster**
   ```powershell
   terraform init
   terraform apply
   aws eks update-kubeconfig --region ap-south-1 --name multicloud-eks

2. Build & Push Images
docker build -t multicloud-frontend .
docker tag multicloud-frontend <account>.dkr.ecr.ap-south-1.amazonaws.com/multicloud-frontend:v3
docker push <account>.dkr.ecr.ap-south-1.amazonaws.com/multicloud-frontend:v3

3. Deploy to Kubernetes
kubectl apply -f k8s/frontend-deployment.yaml
kubectl apply -f k8s/frontend-service.yaml
kubectl apply -f k8s/backend-deployment.yaml
kubectl apply -f k8s/backend-service.yaml

4. Verify

kubectl get pods
kubectl get svc

