# 🌐 MultiCloudApp — AWS CloudOps Platform

## Overview
MultiCloudApp is a **CloudOps Command Center** built on AWS EKS.  
It demonstrates containerized deployments, monitoring, and AI anomaly detection — adaptable for any industry (Healthcare, BFSI, Travel, Retail).

## Current Achievements
- ✅ AWS EKS cluster provisioned with Terraform
- ✅ Dockerized frontend & backend pushed to AWS ECR
- ✅ Kubernetes deployments & services running
- ✅ NodePort/LoadBalancer services exposed
- ✅ PowerShell transcripts for reproducibility

## Future Goals
- Multi‑cloud expansion (Azure, GCP)
- Mobile app layer (React Native / Flutter)
- Sector‑specific dashboards (Hospital, BFSI, Travel, Retail)
- CI/CD pipelines with GitHub Actions
- AI‑powered anomaly detection integrated with Prometheus

## Quick Start
```powershell
terraform init
terraform apply
aws eks update-kubeconfig --region ap-south-1 --name multicloud-eks
kubectl apply -f k8s/



---

### 2. **Supporting Markdown Files (in `/docs`)**

- **SETUP.md** → Installation steps for Windows (Terraform, Docker, kubectl, Helm, AWS CLI).  
- **MONITORING.md** → Prometheus & Grafana setup, dashboard screenshots.  
- **AI.md** → IsolationForest anomaly detection script + integration notes.  
- **FUTURE.md** → Roadmap for hospital, BFSI, travel, retail use cases.  

## 📘 Documentation Links
Explore detailed guides inside the `/docs` folder:
- [Setup Guide](docs/setup.md)
- [Monitoring Guide](docs/monitoring.md)
- [AI Anomaly Detection](docs/ai.md)
- [Architecture Overview](docs/architecture.md)
- [Future Roadmap](docs/future.md)
