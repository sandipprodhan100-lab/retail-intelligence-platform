# MVP Validation Checklist

## 1. Infrastructure Validation

```bash
az group show --name <resource-group-name>
az vm list -g <resource-group-name> -o table
az storage account list -g <resource-group-name> -o table
az datafactory list -g <resource-group-name> -o table
```

Success criteria:

- Resource group exists.
- VM exists and is running.
- Storage account exists with hierarchical namespace enabled.
- ADF exists.

## 2. VM Runtime Validation

SSH to the VM:

```bash
ssh <vm-admin-user>@<vm-public-ip>
```

Check Docker:

```bash
docker --version
docker ps
```

Success criteria:

- Docker is installed.
- PostgreSQL and API containers are running.

## 3. API Validation

```bash
curl http://<vm-public-ip>:8000/api/health
```

Success criteria:

```json
{
  "status": "UP",
  "service": "retail-api",
  "database": "CONNECTED"
}
```

## 4. Database Validation

```bash
docker exec -it retail-postgres psql -U $POSTGRES_USER -d $POSTGRES_DB -c "\dt"
```

Expected tables:

- product
- customer
- stock
- order_header
- order_line

## 5. ADF Validation

- Run each pipeline.
- Confirm success status.
- Confirm ADLS files exist.
- Compare source and target row counts.

## 6. Fabric and Power BI Validation

- Lakehouse can access ADLS data.
- Bronze tables created.
- Semantic model refresh succeeds.
- Power BI visuals show data.
