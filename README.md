<div align="center" style="">

<h1 align="center">🚀 Production-Ready Docker, Kubernetes Boilerplates</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white" alt="Docker">
  <img src="https://img.shields.io/badge/kubernetes-326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white" alt="Kubernetes">
  <img src="https://img.shields.io/github/last-commit/victor3spoir/boilerplates?style=for-the-badge" alt="Last Commit">
</p>
</div>

Hi there, I'm victor3spoir, I'm DevSecOps Practionner & Tech enthousiast, I like writting technicals writes & sharing knowledges.
  
Here, you will find a collections of production ready templates & config files for technologies & tools I have personnaly tested & use in my daily work. I hope you will find here something that can help you.
  
## 🚀 Getting Started

### Docker

⚠️Compose files that need additionnals configuration files are shipped with, as references. but the compose files use docker features `configs` that allow to ship compose files with additionals configurations in the `compose.yml` files. the configs files stand there as reference to default/editable config that you can customize before adding them into the compose file.

```bash
# Create a copy of the service.env config file
cp service.env .env

# Launch the application
docker-compose -f compose.yml up -d
```

### For kubernetes

For Kubernetes deployments

```bash
kubectl apply -f /path/to/config.yml
```

## Feedbacks

Feels free to send feedbacks if you encounter some troubles while using, or find some issues in configurations files.
