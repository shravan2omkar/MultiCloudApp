<<<<<<< HEAD
﻿# ============================
# MultiCloudApp Automation Script
# ============================
# NOTE: Before running this script, replace the values below with your own:
#   - $AWS_ACCOUNT_ID : Your AWS account ID (12-digit number)
#   - $AWS_REGION     : The AWS region where your EKS cluster and ECR repos are created
#   - $ClusterName    : The name of your EKS cluster
#   - Paths (cd ...)  : Update folder paths if your project structure differs
# ============================

# ----------------------------
# Variables (EDIT THESE FOR YOUR ENVIRONMENT)
# ----------------------------
$AWS_ACCOUNT_ID = "654654230083"          # <-- Replace with your AWS Account ID
$AWS_REGION     = "ap-south-1"            # <-- Replace with your AWS Region (e.g., us-east-1)
$ClusterName    = "multiCloudAppCluster"  # <-- Replace with your EKS Cluster name


# ----------------------------
# 1. Terraform Init + Apply
# ----------------------------
Write-Host ">>> Provisioning AWS EKS Cluster with Terraform..."
cd C:\Projects\MultiCloudApp\infrastructure\terraform   # <-- Update path if needed

terraform init
if ($LASTEXITCODE -ne 0) { exit 1 }

terraform apply -auto-approve
if ($LASTEXITCODE -ne 0) { exit 1 }


# ----------------------------
# 2. Update kubeconfig
# ----------------------------
Write-Host ">>> Updating kubeconfig..."
aws eks update-kubeconfig --region $AWS_REGION --name $ClusterName
if ($LASTEXITCODE -ne 0) { exit 1 }


# ----------------------------
# 3. Docker Build + Tag + Push (Frontend & Backend)
# ----------------------------
Write-Host ">>> Authenticating Docker with ECR..."
$token = aws ecr get-login-password --region $AWS_REGION

if ($token) {

    $token | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ECR login failed."
        exit 1
    }

    Write-Host "ECR login succeeded."
}
else {
    Write-Host "ECR login failed — no token received."
    exit 1
}


# ----------------------------
# Build and Push Docker Images
# ----------------------------
Write-Host ">>> Building and pushing Docker images..."

cd C:\Projects\MultiCloudApp\frontend   # <-- Update path if needed
docker build -t multicloud-frontend .
docker tag multicloud-frontend "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/multicloud-frontend:v3"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/multicloud-frontend:v3"

cd C:\Projects\MultiCloudApp\backend    # <-- Update path if needed
docker build -t multicloud-backend .
docker tag multicloud-backend "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/multicloud-backend:latest"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/multicloud-backend:latest"


# ----------------------------
# 4. Apply Kubernetes YAMLs
# ----------------------------
Write-Host ">>> Deploying Kubernetes manifests..."
cd C:\Projects\MultiCloudApp\infrastructure\terraform   # <-- Update path if YAMLs are elsewhere

if (Test-Path frontend-deployment.yaml) { kubectl apply -f frontend-deployment.yaml }
if (Test-Path frontend-service.yaml)   { kubectl apply -f frontend-service.yaml }
if (Test-Path backend-deployment.yaml) { kubectl apply -f backend-deployment.yaml }
if (Test-Path backend-service.yaml)    { kubectl apply -f backend-service.yaml }


# ----------------------------
# 5. Verification
# ----------------------------
Write-Host ">>> Checking pods and services..."
kubectl get pods
kubectl get svc


# ----------------------------
# 6. Collect Full Details into one file
# ----------------------------
Write-Host ">>> Collecting full cluster details..."
"=== Terraform State ===" | Out-File full_details.txt -Encoding utf8
terraform show | Out-File full_details.txt -Append -Encoding utf8

"`n=== EKS Cluster ===" | Out-File full_details.txt -Append -Encoding utf8
aws eks describe-cluster --name $ClusterName --region $AWS_REGION | Out-File full_details.txt -Append -Encoding utf8

"`n=== Nodes ===" | Out-File full_details.txt -Append -Encoding utf8
kubectl get nodes -o wide | Out-File full_details.txt -Append -Encoding utf8

"`n=== Pods ===" | Out-File full_details.txt -Append -Encoding utf8
kubectl get pods -o wide --all-namespaces | Out-File full_details.txt -Append -Encoding utf8

"`n=== Services ===" | Out-File full_details.txt -Append -Encoding utf8
kubectl get svc -o wide --all-namespaces | Out-File full_details.txt -Append -Encoding utf8

"`n=== Deployments ===" | Out-File full_details.txt -Append -Encoding utf8
kubectl get deployments -o wide --all-namespaces | Out-File full_details.txt -Append -Encoding utf8

"`n=== Docker Images ===" | Out-File full_details.txt -Append -Encoding utf8
docker images | Out-File full_details.txt -Append -Encoding utf8

"`n=== ECR Repositories ===" | Out-File full_details.txt -Append -Encoding utf8
aws ecr describe-repositories --region $AWS_REGION | Out-File full_details.txt -Append -Encoding utf8


# ----------------------------
# 7. Merge Docs + Logs and Export to PDF
# ----------------------------
Write-Host ">>> Exporting documentation to PDF..."
cd C:\Projects\MultiCloudApp   # <-- Update path if needed

Get-Content README.md, docs\setup.md, docs\monitoring.md, docs\ai.md, docs\architecture.md, docs\future.md, full_details.txt |
    Out-File ALL_DOCS.md -Encoding utf8

# Strip emojis/box-drawing before Pandoc (XeLaTeX safe)
(Get-Content ALL_DOCS.md) -replace '[^\u0000-\u007F]', '' |
    Out-File ALL_DOCS_CLEAN.md -Encoding utf8

if (Test-Path ALL_DOCS_CLEAN.md) {

    pandoc ALL_DOCS_CLEAN.md -o Full_Project.pdf --pdf-engine=xelatex

    if ($LASTEXITCODE -eq 0) {
        Write-Host ">>> PDF generated successfully!"
    }
    else {
        Write-Host ">>> ERROR: Pandoc failed to generate PDF."
        exit 1
    }
}
else {
    Write-Host ">>> ERROR: Cleaned docs file missing, PDF not generated."
    exit 1
}


# ----------------------------
# Final Confirmation
# ----------------------------
Write-Host ">>> All steps completed successfully!"
=======
﻿# ============================
# MultiCloudApp Automation Script
# ============================
# NOTE: Before running this script, replace the values below with your own:
#   - $AWS_ACCOUNT_ID : Your AWS account ID (12-digit number)
#   - $AWS_REGION     : The AWS region where your EKS cluster and ECR repos are created
#   - $ClusterName    : The name of your EKS cluster
#   - Paths (cd ...)  : Update folder paths if your project structure differs
# ============================

# ----------------------------
# Variables (EDIT THESE FOR YOUR ENVIRONMENT)
# ----------------------------
$AWS_ACCOUNT_ID = "654654230083"          # <-- Replace with your AWS Account ID
$AWS_REGION     = "ap-south-1"            # <-- Replace with your AWS Region (e.g., us-east-1)
$ClusterName    = "multiCloudAppCluster"  # <-- Replace with your EKS Cluster name


# ----------------------------
# 1. Terraform Init + Apply
# ----------------------------
Write-Host ">>> Provisioning AWS EKS Cluster with Terraform..."
cd C:\Projects\MultiCloudApp\infrastructure\terraform   # <-- Update path if needed

terraform init
if ($LASTEXITCODE -ne 0) { exit 1 }

terraform apply -auto-approve
if ($LASTEXITCODE -ne 0) { exit 1 }


# ----------------------------
# 2. Update kubeconfig
# ----------------------------
Write-Host ">>> Updating kubeconfig..."
aws eks update-kubeconfig --region $AWS_REGION --name $ClusterName
if ($LASTEXITCODE -ne 0) { exit 1 }


# ----------------------------
# 3. Docker Build + Tag + Push (Frontend & Backend)
# ----------------------------
Write-Host ">>> Authenticating Docker with ECR..."
$token = aws ecr get-login-password --region $AWS_REGION

if ($token) {

    $token | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ECR login failed."
        exit 1
    }

    Write-Host "ECR login succeeded."
}
else {
    Write-Host "ECR login failed — no token received."
    exit 1
}


# ----------------------------
# Build and Push Docker Images
# ----------------------------
Write-Host ">>> Building and pushing Docker images..."

cd C:\Projects\MultiCloudApp\frontend   # <-- Update path if needed
docker build -t multicloud-frontend .
docker tag multicloud-frontend "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/multicloud-frontend:v3"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/multicloud-frontend:v3"

cd C:\Projects\MultiCloudApp\backend    # <-- Update path if needed
docker build -t multicloud-backend .
docker tag multicloud-backend "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/multicloud-backend:latest"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/multicloud-backend:latest"


# ----------------------------
# 4. Apply Kubernetes YAMLs
# ----------------------------
Write-Host ">>> Deploying Kubernetes manifests..."
cd C:\Projects\MultiCloudApp\infrastructure\terraform   # <-- Update path if YAMLs are elsewhere

if (Test-Path frontend-deployment.yaml) { kubectl apply -f frontend-deployment.yaml }
if (Test-Path frontend-service.yaml)   { kubectl apply -f frontend-service.yaml }
if (Test-Path backend-deployment.yaml) { kubectl apply -f backend-deployment.yaml }
if (Test-Path backend-service.yaml)    { kubectl apply -f backend-service.yaml }


# ----------------------------
# 5. Verification
# ----------------------------
Write-Host ">>> Checking pods and services..."
kubectl get pods
kubectl get svc


# ----------------------------
# 6. Collect Full Details into one file
# ----------------------------
Write-Host ">>> Collecting full cluster details..."
"=== Terraform State ===" | Out-File full_details.txt -Encoding utf8
terraform show | Out-File full_details.txt -Append -Encoding utf8

"`n=== EKS Cluster ===" | Out-File full_details.txt -Append -Encoding utf8
aws eks describe-cluster --name $ClusterName --region $AWS_REGION | Out-File full_details.txt -Append -Encoding utf8

"`n=== Nodes ===" | Out-File full_details.txt -Append -Encoding utf8
kubectl get nodes -o wide | Out-File full_details.txt -Append -Encoding utf8

"`n=== Pods ===" | Out-File full_details.txt -Append -Encoding utf8
kubectl get pods -o wide --all-namespaces | Out-File full_details.txt -Append -Encoding utf8

"`n=== Services ===" | Out-File full_details.txt -Append -Encoding utf8
kubectl get svc -o wide --all-namespaces | Out-File full_details.txt -Append -Encoding utf8

"`n=== Deployments ===" | Out-File full_details.txt -Append -Encoding utf8
kubectl get deployments -o wide --all-namespaces | Out-File full_details.txt -Append -Encoding utf8

"`n=== Docker Images ===" | Out-File full_details.txt -Append -Encoding utf8
docker images | Out-File full_details.txt -Append -Encoding utf8

"`n=== ECR Repositories ===" | Out-File full_details.txt -Append -Encoding utf8
aws ecr describe-repositories --region $AWS_REGION | Out-File full_details.txt -Append -Encoding utf8


# ----------------------------
# 7. Merge Docs + Logs and Export to PDF
# ----------------------------
Write-Host ">>> Exporting documentation to PDF..."
cd C:\Projects\MultiCloudApp   # <-- Update path if needed

Get-Content README.md, docs\setup.md, docs\monitoring.md, docs\ai.md, docs\architecture.md, docs\future.md, full_details.txt |
    Out-File ALL_DOCS.md -Encoding utf8

# Strip emojis/box-drawing before Pandoc (XeLaTeX safe)
(Get-Content ALL_DOCS.md) -replace '[^\u0000-\u007F]', '' |
    Out-File ALL_DOCS_CLEAN.md -Encoding utf8

if (Test-Path ALL_DOCS_CLEAN.md) {

    pandoc ALL_DOCS_CLEAN.md -o Full_Project.pdf --pdf-engine=xelatex

    if ($LASTEXITCODE -eq 0) {
        Write-Host ">>> PDF generated successfully!"
    }
    else {
        Write-Host ">>> ERROR: Pandoc failed to generate PDF."
        exit 1
    }
}
else {
    Write-Host ">>> ERROR: Cleaned docs file missing, PDF not generated."
    exit 1
}


# ----------------------------
# Final Confirmation
# ----------------------------
Write-Host ">>> All steps completed successfully!"
>>>>>>> c753289363eb917f95e00a949f364a4679bcf4c6
