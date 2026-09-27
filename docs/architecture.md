# Architecture

## Current Achievements
- AWS ECR → Docker images
- AWS EKS → Kubernetes cluster
- Terraform → Infrastructure provisioning
- Services → NodePort/LoadBalancer
- Scripts → Secret rotation, AI anomaly detection

## Diagram
AWS Cloud
│
├── ECR (Docker Registry)
│   ├── multicloud-frontend:v3
│   └── multicloud-backend:latest
│
├── EKS Cluster
│   ├── Frontend Deployment
│   ├── Backend Deployment
│   └── Services (LoadBalancer)
│
├── Monitoring
│   ├── Prometheus
│   └── Grafana
│
└── Scripts
├── Secret Rotation
├── Cert Rotation
└── AI Anomaly Detection



## Future Expansion
- Multi‑cloud (Azure, GCP)
- Mobile apps (Android/iOS)
- Sector‑specific dashboards
