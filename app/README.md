# Application README

This section contains the FastAPI application and PostgreSQL database setup scripts.

## Application Scope

The MVP API supports low-volume insert and update operations for:

- Product
- Customer
- Stock
- Order Header
- Order Line

## Local Validation

```bash
cd app
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Health check:

```bash
curl http://localhost:8000/api/health
```

Expected response:

```json
{
  "status": "UP",
  "service": "retail-api",
  "database": "CONNECTED"
}
```

## Database Setup

DDL file:

```text
app/db/ddl.sql
```

Seed data file:

```text
app/db/seed_data.sql
```
