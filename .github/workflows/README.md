# GitHub Actions README

## Workflow 01 - Infra Deploy

File:

```text
01-infra-deploy.yml
```

Manual input:

```text
engine = bicep | terraform | yaml
```

Recommended MVP choice:

```text
bicep
```

## Workflow 02 - App Deploy

Deploys FastAPI and PostgreSQL to the Azure VM.

Required manual input:

```text
vm_public_ip
```

## Workflow 03 - ADF Deploy

Placeholder for future ADF JSON deployment.

For MVP v1, create and validate one ADF pipeline manually first.

## Workflow 04 - Smoke Test

Runs simple API validation checks.

## Required Secrets

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
