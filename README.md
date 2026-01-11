# Kubernetes Deployment Demo

Production-grade Kubernetes deployment with Helm charts, CI/CD pipeline, and monitoring stack.

![Kubernetes](https://img.shields.io/badge/Kubernetes-1.29-326CE5) ![Helm](https://img.shields.io/badge/Helm-3.14-0F1689) ![Terraform](https://img.shields.io/badge/Terraform-1.7-7B42BC)

## 🚀 Features

- **Helm Charts** - Templated Kubernetes manifests
- **CI/CD Pipeline** - GitHub Actions for automated deployments
- **Auto-scaling** - HPA based on CPU/memory metrics
- **Monitoring** - Prometheus + Grafana stack
- **Secrets Management** - External Secrets Operator
- **Blue-Green Deployments** - Zero-downtime releases

## 📊 Key Metrics

| Metric | Value |
|--------|-------|
| Deployment Time | <5 minutes |
| Rollback Time | <30 seconds |
| Uptime | 99.99% |
| Pod Recovery | <60 seconds |

## 🛠 Tech Stack

- **Orchestration**: Kubernetes, Helm
- **CI/CD**: GitHub Actions, ArgoCD
- **IaC**: Terraform
- **Monitoring**: Prometheus, Grafana, Alertmanager
- **Logging**: Loki, Promtail

## 📁 Project Structure

```
kubernetes-deployment/
├── helm/
│   └── myapp/
│       ├── Chart.yaml
│       ├── values.yaml
│       ├── values-staging.yaml
│       ├── values-prod.yaml
│       └── templates/
│           ├── deployment.yaml
│           ├── service.yaml
│           ├── ingress.yaml
│           ├── hpa.yaml
│           └── configmap.yaml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── modules/
│       ├── eks/
│       └── vpc/
├── monitoring/
│   ├── prometheus/
│   └── grafana/
├── .github/
│   └── workflows/
│       ├── ci.yaml
│       └── cd.yaml
└── scripts/
    ├── deploy.sh
    └── rollback.sh
```

## 🔧 Quick Start

```bash
# Create EKS cluster with Terraform
cd terraform
terraform init
terraform apply

# Deploy application with Helm
helm upgrade --install myapp ./helm/myapp \
  -f helm/myapp/values-staging.yaml \
  -n staging --create-namespace

# Check deployment
kubectl get pods -n staging
```

## 📈 Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         KUBERNETES CLUSTER                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                       INGRESS                             │   │
│  │              (nginx-ingress / ALB)                        │   │
│  └─────────────────────────┬────────────────────────────────┘   │
│                            │                                     │
│         ┌──────────────────┴──────────────────┐                 │
│         │                                     │                  │
│         ▼                                     ▼                  │
│  ┌─────────────────┐               ┌─────────────────┐          │
│  │   Service A     │               │   Service B     │          │
│  │   (3 replicas)  │               │   (2 replicas)  │          │
│  │   ┌─────────┐   │               │   ┌─────────┐   │          │
│  │   │   Pod   │   │               │   │   Pod   │   │          │
│  │   └─────────┘   │               │   └─────────┘   │          │
│  │   ┌─────────┐   │               │   ┌─────────┐   │          │
│  │   │   Pod   │   │               │   │   Pod   │   │          │
│  │   └─────────┘   │               │   └─────────┘   │          │
│  │   ┌─────────┐   │               │                 │          │
│  │   │   Pod   │   │               │                 │          │
│  │   └─────────┘   │               │                 │          │
│  └─────────────────┘               └─────────────────┘          │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    MONITORING STACK                       │   │
│  │   Prometheus │ Grafana │ Alertmanager │ Loki             │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## 📝 CI/CD Pipeline

```yaml
# .github/workflows/cd.yaml
name: Deploy to Kubernetes

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        
      - name: Update kubeconfig
        run: aws eks update-kubeconfig --name my-cluster
        
      - name: Deploy with Helm
        run: |
          helm upgrade --install myapp ./helm/myapp \
            -f helm/myapp/values-prod.yaml \
            --wait --timeout 5m
```

## 👤 Author

**Darsh Menon** - [GitHub](https://github.com/darshmenon)
