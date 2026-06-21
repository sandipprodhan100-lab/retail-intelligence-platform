from fastapi import FastAPI
import os
import psycopg2

app = FastAPI(title="Retail Intelligence API", version="0.1.0")


def get_db_connection():
    return psycopg2.connect(
        host=os.getenv("POSTGRES_HOST", "retail-postgres"),
        port=os.getenv("POSTGRES_PORT", "5432"),
        dbname=os.getenv("POSTGRES_DB"),
        user=os.getenv("POSTGRES_USER"),
        password=os.getenv("POSTGRES_PASSWORD"),
    )


@app.get("/api/health")
def health():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT 1")
        cur.close()
        conn.close()
        db_status = "CONNECTED"
    except Exception as exc:
        db_status = f"FAILED: {str(exc)}"

    return {
        "status": "UP" if db_status == "CONNECTED" else "DEGRADED",
        "service": "retail-api",
        "database": db_status,
    }


@app.get("/")
def root():
    return {"message": "Retail Intelligence API MVP"}
