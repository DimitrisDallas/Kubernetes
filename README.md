# Kubernetes

## Purpose

This repository provides resources, configurations, and examples for deploying and managing Kubernetes clusters. It is intended to help users set up a robust container orchestration platform for running scalable, resilient, and portable applications. The repo is suitable for both learning purposes and production deployment scenarios.

## Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/DimitrisDallas/Kubernetes.git
   cd Kubernetes
   ```

2. **Prerequisites**
   - [Docker](https://docs.docker.com/get-docker/)
   - [kubectl](https://kubernetes.io/docs/tasks/tools/)
   - [kubectx](https://github.com/ahmetb/kubectx) (for easier context switching)
   - [kubens](https://github.com/ahmetb/kubectx#kubens) (for namespace switching)
   - Access to a cloud provider or local VM setup (e.g., Minikube, Kind, or kubeadm-based installation)

3. **Initial Configuration**
   - Review the configuration files (such as manifests, Helm charts) in the repo.
   - Adjust cluster configuration (node counts, networking, etc.) as needed for your environment.

## Deploy

### Local Deployment (with Minikube)

```bash
make milkyway
```

## Common Issues

- **Docker Errors:** Ensure your docker daemon is running.
- **Pod CrashLoopBackOff:** Check logs with `kubectl logs <pod>`; review manifest configuration for errors.
- **kubectl Not Configured:** Set up your kubeconfig with `kubectl config` commands or follow cloud provider instructions.

## Troubleshooting

- Use `kubectl describe pod <pod>` for more details on pod failures.
- Check node status with `kubectl get nodes`.
- Review cluster events with `kubectl get events`.

## Contributing

Contributions are welcome! Please open issues or pull requests for bug reports, suggestions, or improvements.

## License

This repository is licensed under the MIT License.
