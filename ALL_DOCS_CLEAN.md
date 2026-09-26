#  MultiCloudApp  AWS CloudOps Platform

## Overview
MultiCloudApp is a **CloudOps Command Center** built on AWS EKS.  
It demonstrates containerized deployments, monitoring, and AI anomaly detection  adaptable for any industry (Healthcare, BFSI, Travel, Retail).

## Current Achievements
-  AWS EKS cluster provisioned with Terraform
-  Dockerized frontend & backend pushed to AWS ECR
-  Kubernetes deployments & services running
-  NodePort/LoadBalancer services exposed
-  PowerShell transcripts for reproducibility

## Future Goals
- Multicloud expansion (Azure, GCP)
- Mobile app layer (React Native / Flutter)
- Sectorspecific dashboards (Hospital, BFSI, Travel, Retail)
- CI/CD pipelines with GitHub Actions
- AIpowered anomaly detection integrated with Prometheus

## Quick Start
```powershell
terraform init
terraform apply
aws eks update-kubeconfig --region ap-south-1 --name multicloud-eks
kubectl apply -f k8s/



---

### 2. **Supporting Markdown Files (in `/docs`)**

- **SETUP.md**  Installation steps for Windows (Terraform, Docker, kubectl, Helm, AWS CLI).  
- **MONITORING.md**  Prometheus & Grafana setup, dashboard screenshots.  
- **AI.md**  IsolationForest anomaly detection script + integration notes.  
- **FUTURE.md**  Roadmap for hospital, BFSI, travel, retail use cases.  

##  Documentation Links
Explore detailed guides inside the `/docs` folder:
- [Setup Guide](docs/setup.md)
- [Monitoring Guide](docs/monitoring.md)
- [AI Anomaly Detection](docs/ai.md)
- [Architecture Overview](docs/architecture.md)
- [Future Roadmap](docs/future.md)
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


---

###  MONITORING.md
```markdown
# Monitoring Setup

## Prometheus
```powershell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/prometheus

Grafana

helm repo add grafana https://grafana.github.io/helm-charts
helm install grafana grafana/grafana

Dashboards
CPU usage

Memory usage

Pod health

API latency


Access Grafana via the LoadBalancer external IP.


---

###  AI.md
```markdown
# AI Anomaly Detection

## Script Example
```python
import pandas as pd
from sklearn.ensemble import IsolationForest

data = pd.DataFrame({"cpu":[20,22,19,95,21,20]})
model = IsolationForest(contamination=0.1)
model.fit(data)
print("Anomaly detection results:", model.predict(data))


Integration
Connect to Prometheus metrics

Detect anomalies in CPU/memory

Trigger alerts or autoscaling


---

###  FUTURE.md
```markdown
# Future Roadmap

## MultiCloud Expansion
- Azure AKS
- GCP GKE
- Hybrid deployments

## Mobile Applications
- **Android (React Native / Kotlin)**
- **iOS (React Native / Swift)**
- Consume backend APIs
- Provide dashboards for different sectors

## Sector Use Cases
-  Hospital  Patient monitoring dashboards
-  BFSI  Transaction anomaly detection
-  Travel  Booking and cluster health visualization
-  Retail  Inventory and sales monitoring

## CI/CD
- GitHub Actions
- Automated builds and deployments
# AI Anomaly Detection

## Overview
This module adds intelligence to the CloudOps platform by detecting unusual behavior in system metrics (CPU, memory, latency). It helps prevent outages and supports predictive scaling.

## Example Script
```python
import pandas as pd
from sklearn.ensemble import IsolationForest

# Sample CPU usage data
data = pd.DataFrame({"cpu":[20,22,19,95,21,20]})

# Train anomaly detection model
model = IsolationForest(contamination=0.1)
model.fit(data)

# Predict anomalies (-1 = anomaly, 1 = normal)
print("Anomaly detection results:", model.predict(data))
# Architecture

## Current Achievements
- AWS ECR  Docker images
- AWS EKS  Kubernetes cluster
- Terraform  Infrastructure provisioning
- Services  NodePort/LoadBalancer
- Scripts  Secret rotation, AI anomaly detection

## Diagram
AWS Cloud

 ECR (Docker Registry)
    multicloud-frontend:v3
    multicloud-backend:latest

 EKS Cluster
    Frontend Deployment
    Backend Deployment
    Services (LoadBalancer)

 Monitoring
    Prometheus
    Grafana

 Scripts
 Secret Rotation
 Cert Rotation
 AI Anomaly Detection



## Future Expansion
- Multicloud (Azure, GCP)
- Mobile apps (Android/iOS)
- Sectorspecific dashboards

---

###  `FUTURE.md`
```markdown
# Future Roadmap

## MultiCloud Expansion
- Extend deployments to **Azure AKS** and **GCP GKE**.
- Hybrid cloud support for resilience and cost optimization.
- Unified Terraform modules for all providers.

## Mobile Applications
- **Android (React Native / Kotlin)** and **iOS (React Native / Swift)**.
- Consume backend APIs for dashboards and alerts.
- Provide native mobile experience for operators and endusers.

## Sector Use Cases
-  **Hospital**  Patient monitoring dashboards, appointment tracking.
-  **BFSI**  Transaction anomaly detection, fraud alerts.
-  **Travel**  Booking status dashboards, cluster health visualization.
-  **Retail**  Inventory and sales monitoring, demand forecasting.

## CI/CD
- GitHub Actions pipelines for automated builds and deployments.
- Continuous testing and security scans.
- Multienvironment deployments (dev, staging, prod).

## Security Automation
- Automated **secret rotation**.
- Certificate renewal scripts.
- ECR cleanup and image lifecycle policies.

## Resume Impact
This roadmap demonstrates the ability to:
- Build a **multicloud, fullstack platform**.
- Extend into **mobile applications** for crosssector use.
- Integrate **AI and monitoring** for enterprise reliability.
=== Terraform State ===
No state.

=== EKS Cluster ===
{
    "cluster": {
        "name": "multiCloudAppCluster",
        "arn": "arn:aws:eks:ap-south-1:654654230083:cluster/multiCloudAppCluster",
        "createdAt": "2026-09-26T21:25:45.515000+05:30",
        "version": "1.36",
        "endpoint": "https://247E3718C7712F06B1E00D1D53854807.gr7.ap-south-1.eks.amazonaws.com",
        "roleArn": "arn:aws:iam::654654230083:role/EKSRole",
        "resourcesVpcConfig": {
            "subnetIds": [
                "subnet-01cc93764b916f596",
                "subnet-0bc3bb43d487ef5e5"
            ],
            "securityGroupIds": [
                "sg-0a6fa3bad81f7b634"
            ],
            "clusterSecurityGroupId": "sg-0a1e37df2d8541e59",
            "vpcId": "vpc-027bdb9741258fbc7",
            "endpointPublicAccess": true,
            "endpointPrivateAccess": false,
            "publicAccessCidrs": [
                "0.0.0.0/0"
            ],
            "controlPlaneEgressMode": "AWS_MANAGED"
        },
        "kubernetesNetworkConfig": {
            "serviceIpv4Cidr": "10.100.0.0/16",
            "ipFamily": "ipv4",
            "elasticLoadBalancing": {
                "enabled": false
            }
        },
        "logging": {
            "clusterLogging": [
                {
                    "types": [
                        "api",
                        "audit",
                        "authenticator",
                        "controllerManager",
                        "scheduler"
                    ],
                    "enabled": false
                }
            ]
        },
        "identity": {
            "oidc": {
                "issuer": "https://oidc.eks.ap-south-1.amazonaws.com/id/247E3718C7712F06B1E00D1D53854807"
            }
        },
        "status": "ACTIVE",
        "certificateAuthority": {
            "data": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURNakNDQWhxZ0F3SUJBZ0lSQUtIU3dkUC91RXNQcXdPdGI5bm4yYXd3RFFZSktvWklodmNOQVFFTEJRQXcKSnpFUU1BNEdBMVVFQ2hNSFFWZFRJRVZMVXpFVE1CRUdBMVVFQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TmpBNQpNall4TlRVMU5UVmFGdzB6TVRBNU1qVXhOVFUxTlRWYU1DY3hFREFPQmdOVkJBb1RCMEZYVXlCRlMxTXhFekFSCkJnTlZCQU1UQ210MVltVnlibVYwWlhNd2dnRWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUJEd0F3Z2dFS0FvSUIKQVFEUEEwSDFGLzJHNVNmbFkxdU5jV1hpT0t1RjhDbnp3aGNyN29oMmE1WE9WcnExTkdmUU1vZ3dUa2VFdm9IcQo4b2FGbllOOWZudlZDQmw4MGJyL20veEJjT3pGMVRvNlZPLytGYWZnQ3N5TVd6dUlXbWtXczVLN0hpRm10S284CmxSS2s3Wmgxek5tSmptZFhNTXNPYUkrSmRzT3kzTms1dDhEZFE1cDA0RzFHcUNJalJFdjBHQWRLNzA2Qlo3ZGMKZ1BUcVNCWmJXdGtBb2xSYmVqYjlYMjN0UlVXUkx5UlhTeVM3VDB3TGNob1k0RHNadDliMExseVpvTEd2ckN3OAprbGJmbmZVa3dEVkZvZDJkdmJiNG5tUFU5R0dzVjBjeTlFWi8wRUZZcm9UdkxXUDVhZXU3SFJPMVZyYXRGbW1qCnlha1pWQW0zZ2o2aW1hbXZxZ0UvTzc5SEFnTUJBQUdqV1RCWE1BNEdBMVVkRHdFQi93UUVBd0lDcERBUEJnTlYKSFJNQkFmOEVCVEFEQVFIL01CMEdBMVVkRGdRV0JCU0NLMkNYZnlRNFBnUU1QWnVkQkJLaGhLWWxnREFWQmdOVgpIUkVFRGpBTWdncHJkV0psY201bGRHVnpNQTBHQ1NxR1NJYjNEUUVCQ3dVQUE0SUJBUUNPL2MxaTlaOTlWbXdWCnJKZjRmOHY2dTJodjlRMzFtYXhZU0JIeTl2Y0JPVXUyK0FDUUxmTEVjSUN1QzFjR0k0SjJTUmpFNnBydlB1TkYKSmhHSHlDby96STVrZ2Y3SVZjWXdSQjRTRHlsaTQxUnVwVm85Slg2SVJFQzBONy95eWFnM05ua0QxeGlhOVF0ZwpkMzF4eS9uT1VYR1o3TVlNdTVucXZvS1Y4QjdMMC9pZDVCNWRONVRqaGdQSXM3ZGZSdlhsaTlVUUxQTDFwM0tjCnloVjNzN2NSY2I1QkJpWXM0VnMwU080dEpsbDExek5GY2NlcC91SVc5b1dJZnhIblFuRDhyZGpkZnh6U2h6VWgKYkZXQUxGK0JCR2FsT0Q0OUhwTEJzQXB3MGg1dnRsRmlaaDhhMTlyb0U2T3B0eTJ4Z1Jqdk1IWkZKOHFiS3lhZwpFT1hhZ3hEdQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==",
            "active": {
                "id": "c6a5ae7a-2567-336c-8f61-bb239d7c2daf",
                "activatedBy": "EKS"
            }
        },
        "platformVersion": "eks.14",
        "tags": {},
        "accessConfig": {
            "authenticationMode": "CONFIG_MAP"
        },
        "upgradePolicy": {
            "supportType": "EXTENDED"
        },
        "computeConfig": {
            "enabled": false,
            "nodePools": []
        },
        "storageConfig": {
            "blockStorage": {
                "enabled": false
            }
        },
        "deletionProtection": false,
        "controlPlaneScalingConfig": {
            "tier": "standard"
        },
        "kubeApiServerConfig": {
            "eventTtl": "60m",
            "serviceNodePortRange": {
                "minPort": 30000,
                "maxPort": 32767
            }
        },
        "kubeSchedulerConfig": {
            "nodeResourcesFit": {
                "scoringStrategy": {
                    "type": "LeastAllocated",
                    "resources": [
                        {
                            "name": "cpu",
                            "weight": 1
                        },
                        {
                            "name": "memory",
                            "weight": 1
                        }
                    ]
                }
            }
        },
        "kubeControllerManagerConfig": {
            "podGcControllerConfig": {
                "terminatedPodGcThreshold": 12500
            },
            "horizontalPodAutoscalerControllerConfig": {
                "horizontalPodAutoscalerSyncPeriod": "15s"
            }
        }
    }
}

=== Nodes ===
NAME                                          STATUS   ROLES    AGE   VERSION               INTERNAL-IP    EXTERNAL-IP     OS-IMAGE                        KERNEL-VERSION                            CONTAINER-RUNTIME
ip-172-31-22-72.ap-south-1.compute.internal   Ready    <none>   3h    v1.36.4-eks-f4fc4f1   172.31.22.72   13.233.75.222   Amazon Linux 2023.12.20260918   6.18.48-109.150.amzn2023.x86_64 (amd64)   containerd://2.2.7+unknown

=== Pods ===
NAMESPACE     NAME                        READY   STATUS    RESTARTS   AGE     IP             NODE                                          NOMINATED NODE   READINESS GATES
default       backend-567c657ff-kv7l4     1/1     Running   0          129m    172.31.18.62   ip-172-31-22-72.ap-south-1.compute.internal   <none>           <none>
default       frontend-6d558c869c-rm4fz   1/1     Running   0          92m     172.31.16.21   ip-172-31-22-72.ap-south-1.compute.internal   <none>           <none>
default       nginx-7f8fbb96d-8rm6t       1/1     Running   0          3h32m   172.31.19.91   ip-172-31-22-72.ap-south-1.compute.internal   <none>           <none>
kube-system   aws-node-ggrzq              2/2     Running   0          3h      172.31.22.72   ip-172-31-22-72.ap-south-1.compute.internal   <none>           <none>
kube-system   coredns-645b58c966-6w66t    1/1     Running   0          3h8m    172.31.17.74   ip-172-31-22-72.ap-south-1.compute.internal   <none>           <none>
kube-system   coredns-645b58c966-dtf6b    1/1     Running   0          3h3m    172.31.20.85   ip-172-31-22-72.ap-south-1.compute.internal   <none>           <none>
kube-system   kube-proxy-p9fsw            1/1     Running   0          3h      172.31.22.72   ip-172-31-22-72.ap-south-1.compute.internal   <none>           <none>

=== Services ===
NAMESPACE     NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE     SELECTOR
default       backend-service             NodePort    10.100.141.170   <none>        5000:32551/TCP           129m    app=backend
default       frontend-service            NodePort    10.100.59.146    <none>        3000:32552/TCP           125m    app=frontend
default       kubernetes                  ClusterIP   10.100.0.1       <none>        443/TCP                  3h44m   <none>
default       nginx                       NodePort    10.100.66.9      <none>        80:32550/TCP             176m    app=nginx
kube-system   eks-extension-metrics-api   ClusterIP   10.100.42.232    <none>        443/TCP                  3h44m   <none>
kube-system   kube-dns                    ClusterIP   10.100.0.10      <none>        53/UDP,53/TCP,9153/TCP   3h43m   k8s-app=kube-dns

=== Deployments ===
NAMESPACE     NAME       READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS   IMAGES                                                                          SELECTOR
default       backend    1/1     1            1           129m    backend      654654230083.dkr.ecr.ap-south-1.amazonaws.com/multicloud-backend:v1             app=backend
default       frontend   1/1     1            1           110m    frontend     654654230083.dkr.ecr.ap-south-1.amazonaws.com/multicloud-frontend:v3            app=frontend
default       nginx      1/1     1            1           3h32m   nginx        nginx                                                                           app=nginx
kube-system   coredns    2/2     2            2           3h43m   coredns      602401143452.dkr.ecr.ap-south-1.amazonaws.com/eks/coredns:v1.14.3-eksbuild.16   eks.amazonaws.com/component=coredns,k8s-app=kube-dns

=== Docker Images ===
REPOSITORY                                                          TAG         IMAGE ID       CREATED        SIZE
123456789012.dkr.ecr.ap-south-1.amazonaws.com/multicloud-frontend   v3          2b8fff5525c6   2 hours ago    709MB
654654230083.dkr.ecr.ap-south-1.amazonaws.com/multicloud-frontend   v3          2b8fff5525c6   2 hours ago    709MB
multicloud-frontend                                                 latest      2b8fff5525c6   2 hours ago    709MB
654654230083.dkr.ecr.ap-south-1.amazonaws.com/multicloud-frontend   v1          0ef1c2d9457c   6 hours ago    709MB
multicloudapp-frontend                                              latest      623c7be321ff   6 hours ago    709MB
multicloudapp-backend                                               latest      91ec98d4e4c4   7 hours ago    133MB
654654230083.dkr.ecr.ap-south-1.amazonaws.com/multicloud-backend    v1          f8217a76582b   7 hours ago    133MB
multicloud-backend                                                  latest      f8217a76582b   7 hours ago    133MB
123456789012.dkr.ecr.ap-south-1.amazonaws.com/multicloud-backend    latest      f8217a76582b   7 hours ago    133MB
thavrix-infra-thavrix-api                                           latest      8bd9fa850f55   3 months ago   148MB
<none>                                                              <none>      fcb8664233c1   3 months ago   142MB
prom/prometheus                                                     latest      d2f7aaa363e1   4 months ago   436MB
thavrix-infra-thavrix-web                                           latest      f31ae8e802c5   4 months ago   62.5MB
<none>                                                              <none>      918a2d9c996a   4 months ago   62.5MB
<none>                                                              <none>      f671c4de62c5   4 months ago   142MB
node                                                                24-slim     f5706f589c48   4 months ago   226MB
postgres                                                            15-alpine   5cce759a2777   4 months ago   274MB
grafana/grafana                                                     latest      ffe38074db41   4 months ago   1.07GB
hello-world                                                         latest      e2ac70e7319a   6 months ago   10.1kB

=== ECR Repositories ===
{
    "repositories": [
        {
            "repositoryArn": "arn:aws:ecr:ap-south-1:654654230083:repository/multicloud-frontend",
            "registryId": "654654230083",
            "repositoryName": "multicloud-frontend",
            "repositoryUri": "654654230083.dkr.ecr.ap-south-1.amazonaws.com/multicloud-frontend",
            "createdAt": "2026-09-26T23:19:45.972000+05:30",
            "imageTagMutability": "MUTABLE",
            "imageScanningConfiguration": {
                "scanOnPush": false
            },
            "encryptionConfiguration": {
                "encryptionType": "AES256"
            }
        },
        {
            "repositoryArn": "arn:aws:ecr:ap-south-1:654654230083:repository/multicloud-backend",
            "registryId": "654654230083",
            "repositoryName": "multicloud-backend",
            "repositoryUri": "654654230083.dkr.ecr.ap-south-1.amazonaws.com/multicloud-backend",
            "createdAt": "2026-09-26T22:58:06.869000+05:30",
            "imageTagMutability": "MUTABLE",
            "imageScanningConfiguration": {
                "scanOnPush": false
            },
            "encryptionConfiguration": {
                "encryptionType": "AES256"
            }
        }
    ]
}
