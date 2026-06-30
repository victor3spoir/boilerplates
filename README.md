<div align="center">
  <img src="./assets/boilerplates-banner.svg" alt="Boilerplates banner" width="100%" />
</div>

<div align="center">

<h1 align="center">Production-Ready Infrastructure Boilerplates</h1>

<p align="center">
  Reusable templates for Docker, Kubernetes, Ansible, Terraform, and related infra tooling.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white" alt="Docker">
  <img src="https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white" alt="Kubernetes">
  <img src="https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white" alt="Ansible">
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" alt="Terraform">
</p>

</div>

I’m Victor, a DevSecOps practitioner and technical writer. This repository collects infrastructure boilerplates I use, test, and reuse in real work.

The goal is simple: keep production-ready starting points for common infrastructure tasks in one place, so the hard parts are already wired and the remaining work is project-specific.

## What’s inside

- `docker-compose/`: categorized Compose stacks for databases, brokers, identity, observability, monitoring, firewalls, storage, CMS, media, automation, AI, registries, dashboards, and service examples.
- `kubernetes/`: reusable manifests for base objects such as `Deployment`, `Service`, `Ingress`, `PVC`, `PV`, `Secret`, and `StatefulSet`, plus app-specific examples like Traefik, PostgreSQL, MongoDB, and Nextcloud.
- `ansible/`: playbooks, inventory, and build files for provisioning hosts and automating repeatable system setup.
- `config/`: shared Dockerfiles, Git configuration, SSH configuration, and GitLab CI templates and components.
- `templates/`: starter templates for Compose, Dev Containers, and Traefik dynamic configuration.
- `terraform/`: Terraform examples, including a Docker-oriented intro stack.
- `cloud-config/`: cloud-init bootstrap configuration.
- `devcontainers/`: ready-to-use development container setups.

## Purpose

This is not a single application repository. It is a library of self-contained starting points you can copy, adapt, and combine.

Most folders include:

- configuration files close to the service they configure
- environment files or config samples where needed
- deployment examples for local, staging, or infrastructure use
- defaults that are intentionally easy to override

## Contributing

Contributions are welcome when they improve clarity, correctness, or usability.

Before opening a pull request:

- keep changes focused on one boilerplate or one improvement
- prefer production-oriented defaults over opinionated extras
- make sure file paths, environment variables, and references are consistent
- update related docs when behavior changes

If you want to add a new boilerplate, keep the folder structure predictable and mirror the style already used in the repository.

## Notes

- The repository is organized by technology and use case, not by application framework.
- Configuration files are intentionally kept close to their service definitions so they can be copied, overridden, or adapted quickly.
- Many examples include default values, placeholder credentials, or staging settings that should be changed before production use.

## Feedback

If you find a broken config, a missing example, or a clearer way to structure a boilerplate, open an issue or send feedback.

## Contact

Write me at [victorespoir.dev@gmail.com](mailto:victorespoir.dev@gmail.com) if you want to suggest a missing category, request a structure cleanup, or discuss a boilerplate pattern.

## License

See [LICENCE](/run/media/victor3spoir/Data/dev/projects/boilerplates/LICENCE) for the repository license.
