# ============================
# MultiCloudApp Automation Script with Screenshots
# ============================

# Variables
$AWS_ACCOUNT_ID = "654654230083"
$AWS_REGION     = "ap-south-1"
$ClusterName    = "multiCloudAppCluster"
$savePath       = "C:\Projects\MultiCloudApp\screenshots"

if (!(Test-Path $savePath)) {
    New-Item -ItemType Directory -Path $savePath | Out-Null
}

# Screenshot helper
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Capture-Screen($name) {
    $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $bitmap = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size)
    $timestamp = (Get-Date).ToString("yyyy-MM-dd_HH-mm-ss")
    $file = "$savePath\$name-$timestamp.png"
    $bitmap.Save($file, [System.Drawing.Imaging.ImageFormat]::Png)
    $graphics.Dispose()
    $bitmap.Dispose()
    Write-Host "Saved screenshot: $file"
}

# ----------------------------
# 1. Terraform Init + Apply
# ----------------------------
Write-Host ">>> Provisioning AWS EKS Cluster with Terraform..."
cd C:\Projects\MultiCloudApp\infrastructure\terraform
terraform init
terraform apply -auto-approve
Capture-Screen "terraform-apply"

# ----------------------------
# 2. Update kubeconfig
# ----------------------------
Write-Host ">>> Updating kubeconfig..."
aws eks update-kubeconfig --region $AWS_REGION --name $ClusterName
Capture-Screen "eks-kubeconfig"

# ----------------------------
# 3. Docker Build + Push
# ----------------------------
Write-Host ">>> Authenticating Docker with ECR..."
$token = aws ecr get-login-password --region $AWS_REGION
if ($token) {
    $token | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
    Write-Host "ECR login succeeded."
} else {
    Write-Host "ECR login failed."
    exit 1
}

Write-Host ">>> Building and pushing Docker images..."
cd C:\Projects\MultiCloudApp\frontend
docker build -t multicloud-frontend .
docker tag multicloud-frontend "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/multicloud-frontend:v3"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/multicloud-frontend:v3"

cd C:\Projects\MultiCloudApp\backend
docker build -t multicloud-backend .
docker tag multicloud-backend "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/multicloud-backend:latest"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/multicloud-backend:latest"

Capture-Screen "docker-build-push"

# ----------------------------
# 4. Apply Kubernetes YAMLs
# ----------------------------
Write-Host ">>> Deploying Kubernetes manifests..."
cd C:\Projects\MultiCloudApp\infrastructure\terraform
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml
kubectl apply -f backend-deployment.yaml
kubectl apply -f backend-service.yaml
Capture-Screen "k8s-deployments"

# ----------------------------
# 5. Verification
# ----------------------------
Write-Host ">>> Checking pods and services..."
kubectl get pods
kubectl get svc
Capture-Screen "k8s-verification"

# ----------------------------
# 6. Launch Dashboards + Screenshots
# ----------------------------
Write-Host ">>> Opening dashboards and capturing screenshots..."

# Docker Desktop
Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
Start-Sleep -Seconds 10
Capture-Screen "docker-desktop"

# AWS Console URLs
$urls = @(
    "https://console.aws.amazon.com/ec2/v2/home",
    "https://console.aws.amazon.com/eks/home",
    "https://console.aws.amazon.com/ecr/home",
    "https://console.aws.amazon.com/vpc/home",
    "https://console.aws.amazon.com/iam/home",
    "https://console.aws.amazon.com/vpc/home#subnets"
)

$i = 1
foreach ($url in $urls) {
    Start-Process $url
    Start-Sleep -Seconds 10
    Capture-Screen "aws-console-$i"
    $i++
}

# ----------------------------
# Final Confirmation
# ----------------------------
Write-Host ">>> All steps and screenshots completed successfully!"
