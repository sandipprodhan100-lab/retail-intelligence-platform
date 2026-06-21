# Infrastructure README

This folder contains three infrastructure options for the MVP.

## Folders

```text
infra/bicep      Azure-native Bicep modules
infra/terraform  Terraform configuration
infra/yaml       YAML-driven Azure CLI deployment example
infra/config     Shared configuration values
```

## Recommended Option

Use Bicep first for the MVP because it is native to Azure and keeps the first deployment simple.

## Deployment Selection

Use GitHub Actions workflow:

```text
.github/workflows/01-infra-deploy.yml
```

Select one of:

```text
bicep
terraform
yaml
```

## Security Rule

Do not store passwords, client secrets or SSH private keys in files. Use GitHub Secrets.
