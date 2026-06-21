# Retail Intelligence Integration Platform - MVP

This repository contains the MVP implementation scaffold for a retail data integration and analytics platform.

## MVP Scope

The MVP focuses on:

1. FastAPI service for product, customer, stock and order data.
2. PostgreSQL running on an Azure Linux VM using Docker.
3. Azure Data Factory copying PostgreSQL tables to ADLS Gen2.
4. ADLS Gen2 raw zone for retail analytical files.
5. Microsoft Fabric Lakehouse and Power BI report design.
6. GitHub Actions driven deployment using selectable infrastructure engines.

## Infrastructure Engine Options

The GitHub Actions workflow allows you to choose one of:

| Engine | Folder | Recommended Use |
|---|---|---|
| Bicep | `infra/bicep` | Primary MVP option for Azure-native IaC |
| Terraform | `infra/terraform` | Alternative IaC option for cross-cloud style practice |
| YAML | `infra/yaml` | Config-driven Azure CLI deployment example |

## Human-in-the-loop Items

The following must be configured manually:

- Azure subscription access.
- GitHub OIDC federated identity.
- GitHub environment secrets.
- PostgreSQL password.
- SSH public/private key management.
- Fabric workspace and Power BI report setup for the first MVP version.

## Required GitHub Secrets

Create these in GitHub Repository or Environment secrets:

```text
AZURE_CLIENT_ID
AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID
POSTGRES_USER
POSTGRES_PASSWORD
POSTGRES_DB
VM_ADMIN_USERNAME
VM_SSH_PUBLIC_KEY
VM_SSH_PRIVATE_KEY
```

## Recommended Build Order

1. Configure GitHub secrets and OIDC.
2. Run `01-infra-deploy.yml` using `bicep`.
3. Run `02-app-deploy.yml`.
4. Validate API health endpoint.
5. Deploy or manually create ADF linked services and pipelines.
6. Trigger ADF pipeline to land data in ADLS Gen2.
7. Connect Fabric Lakehouse and build Power BI report.

## MVP Validation

See `docs/validation/README.md` for validation steps.
