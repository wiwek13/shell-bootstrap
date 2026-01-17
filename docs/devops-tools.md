# DevOps Tools Guide ☸️

[![Kubernetes](https://img.shields.io/badge/Kubernetes-Ready-blue?logo=kubernetes)](https://kubernetes.io/)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-purple?logo=terraform)](https://www.terraform.io/)
[![Docker](https://img.shields.io/badge/Docker-Containers-blue?logo=docker)](https://www.docker.com/)

> **Complete guide to Kubernetes, Terraform, Docker, and cloud CLI tools for DevOps engineers.**

Master kubectl, helm, k9s, terraform, and more with practical examples and workflows.

**Tools covered:** kubectl, kubectx, k9s, stern, helm, kustomize, argocd, docker, dive, trivy, terraform, tfswitch, awscli, grpcurl

---

## ☸️ Kubernetes

### `kubectl` - Kubernetes CLI
```bash
# Basics
kubectl get pods                    # List pods
kubectl get pods -A                 # All namespaces
kubectl get pods -o wide            # More details
kubectl describe pod <name>         # Pod details
kubectl logs <pod>                  # View logs
kubectl logs -f <pod>               # Follow logs

# Executing
kubectl exec -it <pod> -- bash      # Shell into pod
kubectl exec <pod> -- cat /etc/hosts # Run command

# Resources
kubectl get all                     # All resources
kubectl get svc,deploy,pods         # Multiple types
kubectl get pods --show-labels      # With labels

# Apply/Delete
kubectl apply -f manifest.yaml      # Apply config
kubectl delete -f manifest.yaml     # Delete
kubectl delete pod <name>           # Delete pod
```

### `kubectx` / `kubens` - Context/Namespace Switch
```bash
kubectx                  # List contexts
kubectx production       # Switch to production
kubectx -                # Switch back to previous

kubens                   # List namespaces
kubens kube-system       # Switch namespace
kubens -                 # Switch back

# Aliases (from shell-bootstrap)
kx                       # kubectx
kn                       # kubens
```

### `k9s` - Kubernetes TUI
```bash
k9s                      # Launch TUI
k9s -n kube-system       # Start in namespace
k9s -c pods              # Start showing pods

# Keybindings:
# : = command mode (type resource name)
# / = filter
# d = describe
# l = logs
# s = shell
# ctrl+d = delete
# q = quit
```

### `stern` - Multi-pod Log Tailing
```bash
stern api                # Logs from pods matching "api"
stern -n prod api        # In specific namespace
stern --since 5m api     # Last 5 minutes
stern -l app=web         # By label selector
stern -c nginx api       # Specific container

# What it does: Tail logs from multiple pods at once
# When to use: Debugging microservices
```

### `helm` - Kubernetes Package Manager
```bash
# Repositories
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo nginx

# Install
helm install my-nginx bitnami/nginx
helm install my-app ./chart -f values.yaml
helm install my-app ./chart --set replicas=3

# Manage
helm list                # List releases
helm status my-app       # Release status
helm upgrade my-app ./chart
helm rollback my-app 1   # Rollback to revision 1
helm uninstall my-app
```

### `kustomize` - Config Customization
```bash
# Build
kustomize build ./overlay/prod
kustomize build ./overlay/prod | kubectl apply -f -

# Preview
kubectl apply -k ./overlay/prod --dry-run=client

# What it does: Template-free config customization
# When to use: Managing configs across environments
```

### `argocd` - GitOps CLI
```bash
argocd login argocd.example.com
argocd app list
argocd app sync my-app
argocd app get my-app
argocd app history my-app

# What it does: GitOps continuous delivery
# When to use: Deploying apps from Git
```

---

## 🐳 Docker

### Docker Basics
```bash
# Containers
docker ps                    # Running containers
docker ps -a                 # All containers
docker run -it ubuntu bash   # Interactive container
docker exec -it <id> bash    # Shell into running
docker stop <id>             # Stop container
docker rm <id>               # Remove container

# Images
docker images                # List images
docker pull nginx            # Pull image
docker build -t myapp .      # Build image
docker rmi <image>           # Remove image

# Cleanup
docker system prune          # Remove unused
docker system prune -a       # Remove all unused
```

### `dive` - Image Layer Explorer
```bash
dive nginx:latest            # Analyze image
dive build -t myapp .        # Build and analyze

# Keybindings:
# Tab = switch panels
# Space = collapse/expand
# Ctrl+U = filter unchanged
# Ctrl+A = show added
# Ctrl+R = show removed

# What it does: Explore image layers, find bloat
# When to use: Optimizing Docker images
```

### `trivy` - Security Scanner
```bash
trivy image nginx:latest     # Scan image
trivy image --severity HIGH,CRITICAL nginx
trivy fs .                   # Scan filesystem
trivy config .               # Scan IaC configs

# What it does: Find vulnerabilities in images/code
# When to use: Security audits, CI/CD pipelines
```

### OrbStack (Docker Alternative)
```bash
# OrbStack provides docker CLI compatibility
docker ps                    # Works with OrbStack
docker-compose up            # Works with OrbStack

# Benefits over Docker Desktop:
# - Faster startup
# - Less memory usage
# - Native Linux VMs
```

---

## 🏗️ Terraform

### `terraform` - Infrastructure as Code
```bash
# Workflow
terraform init               # Initialize
terraform plan               # Preview changes
terraform apply              # Apply changes
terraform destroy            # Destroy infrastructure

# State
terraform state list         # List resources
terraform state show aws_instance.web
terraform state mv           # Rename resource
terraform import             # Import existing

# Workspaces
terraform workspace list
terraform workspace new staging
terraform workspace select staging
```

### `tfswitch` - Version Manager
```bash
tfswitch                     # Interactive select
tfswitch 1.6.0               # Switch to version
tfswitch -l                  # List installed

# What it does: Multiple Terraform versions
# When to use: Projects need different TF versions
```

### Terraform Aliases (from shell-bootstrap)
```bash
tf                           # terraform
tfi                          # terraform init
tfp                          # terraform plan
tfa                          # terraform apply
tfaa                         # terraform apply -auto-approve
tfd                          # terraform destroy
tfsl                         # terraform state list
tfss                         # terraform state show
```

---

## ☁️ Cloud CLIs

### `awscli` - AWS CLI
```bash
# Configure
aws configure                # Setup credentials
aws configure --profile prod # Named profile
export AWS_PROFILE=prod      # Use profile

# Common commands
aws s3 ls                    # List S3 buckets
aws s3 cp file.txt s3://bucket/
aws ec2 describe-instances
aws sts get-caller-identity  # Whoami

# SSO
aws sso login --profile prod
```

### `kubectl-ai` - AI-powered kubectl
```bash
kubectl-ai "get all pods not running"
kubectl-ai "scale deployment web to 5 replicas"
kubectl-ai "show me pods using most memory"

# What it does: Natural language to kubectl
# When to use: Complex queries you can't remember
```

---

## 🔧 Debugging Tools

### `grpcurl` - gRPC Debugging
```bash
# List services
grpcurl -plaintext localhost:50051 list

# Describe service
grpcurl -plaintext localhost:50051 describe MyService

# Call method
grpcurl -plaintext -d '{"name":"test"}' \
  localhost:50051 mypackage.MyService/MyMethod

# What it does: curl for gRPC
# When to use: Testing gRPC services
```

### `httpie` - HTTP Testing
```bash
http GET api.example.com/health
http POST api.example.com/users name=john
http -v GET api.example.com     # Verbose

# What it does: Human-friendly HTTP client
# When to use: API testing
```

---

## 🎯 DevOps Workflows

### Daily Kubernetes Workflow
```bash
# Morning check
kx production && kn default
kgp                          # Check pods
stern -n default --since 1h  # Check recent logs

# Debugging issue
kl <pod>                     # View logs
kex <pod>                    # Shell in
kdesc pod <name>             # Details
```

### Deployment Workflow
```bash
# Terraform
cd infra/
tfi && tfp                   # Init and plan
tfa                          # Apply after review

# Kubernetes
cd k8s/
helm upgrade --install app ./chart -f values-prod.yaml
kubectl rollout status deploy/app
```
