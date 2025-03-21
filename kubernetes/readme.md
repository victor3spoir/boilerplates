# Docs


## Artifacts site

<https://artifacthub.io/>

## Enable ingress

```bash
  minikube -p profile addons enable ingress
```

## Add traefik ingress controller

```bash
  helm repo add traefik https://helm.traefik.io/traefik
  helm repo update
  helm install traefik traefik/traefik
```