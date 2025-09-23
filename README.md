
# Wisecow — Cow Wisdom Web Server

## Overview

Wisecow is a simple web server application that displays cow-themed wisdom messages. This project includes a Dockerized Kubernetes deployment and a GitHub Actions CI/CD pipeline for automatic container image building and Kubernetes deployment.

***

## Prerequisites

To run Wisecow locally or on Kubernetes, ensure you have:

- Docker installed
- Minikube or Kubernetes cluster access
- `kubectl` CLI installed
- Installed dependencies for local runs:

```bash
sudo apt install fortune-mod cowsay -y
```


***

## How to Run Locally

1. Run the shell script:

```bash
./wisecow.sh
```

2. Point your browser to `http://localhost:4499` (default port).

***

## Kubernetes Deployment

### What’s Included?

- A Dockerfile to build the Wisecow image.
- Kubernetes manifests (`wisecow-deployment.yaml`, `wisecow-service.yaml`) to deploy the app and expose it as a service.
- GitHub Actions workflow YAML to automate:
    - Image build \& push on code changes.
    - Kubernetes deployment to a cluster.


### Note on GitHub Actions and Minikube

The current GitHub Actions workflow assumes access to a Kubernetes cluster with proper kubeconfig configuration. When running with **local Minikube**, GitHub Actions cannot directly connect to your local Kubernetes cluster, resulting in errors like:

```
The connection to the server localhost:8080 was refused - did you specify the right host or port?
```


#### What This Means

- Minikube is local to your machine and not accessible by GitHub runners.
- Kubeconfig file needs proper setup and exposure.
- For cloud clusters (e.g., GKE, EKS, AKS), workflows can connect remotely and deploy automatically.
- For Minikube, consider deploying manually or pushing images with GitHub and then deploying locally.

***

## How to Use GitHub Actions Properly in This Scenario

- Push changes to your branch to trigger image build and push to your container registry.
- Deploy the new image manually to your local Minikube cluster using:

```bash
kubectl apply -f k8s/wisecow-deployment.yaml
kubectl apply -f k8s/wisecow-service.yaml
```


***

## TLS and Secure Communication

The Wisecow app supports TLS-secured communication. Configurations and certificates are included in the Kubernetes manifests and image for secure traffic.

***

## Project Structure

```

├── Dockerfile
├── k8s/
│   ├── wisecow-deployment.yaml
│   └── wisecow-service.yaml
├── .github/
│   └── workflows/
│       └── build-and-deploy.yaml
├── wisecow.sh
└── README.md
```


***

## Summary

This repo contains a fully dockerized cow wisdom web server with Kubernetes deployment manifests and CI/CD through GitHub Actions. Due to Minikube local constraints, some workflow steps require manual intervention or cloud cluster integration for full automation.

***



[^1]: https://github.com/Jothikasanthanam/wisecow

