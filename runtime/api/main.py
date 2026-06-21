import os
import psycopg2
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="Retail Intelligence API")


def get_connection():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=os.getenv("DB_PORT", "5432"),
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
    )


class Product(BaseModel):
    product_code: str
    product_name: str
    category: str
    price: float


@app.get("/health")
def health():
    try:
        conn = get_connection()
        cur = conn.cursor()
        cur.execute("SELECT 1")
        cur.close()
        conn.close()

        return {
            "status": "UP",
            "service": "retail-intelligence-api",
            "database": "CONNECTED"
        }
    except Exception as e:
        return {
            "status": "DOWN",
            "service": "retail-intelligence-api",
            "database": "FAILED",
            "error": str(e)
        }


@app.post("/products")
def create_product(product: Product):
    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        INSERT INTO products(product_code, product_name, category, price)
        VALUES (%s, %s, %s, %s)
        ON CONFLICT (product_code)
        DO UPDATE SET
            product_name = EXCLUDED.product_name,
            category = EXCLUDED.category,
            price = EXCLUDED.price
        RETURNING product_id
        """,
        (
            product.product_code,
            product.product_name,
            product.category,
            product.price,
        ),
    )

    product_id = cur.fetchone()[0]
    conn.commit()
    cur.close()
    conn.close()

    return {
        "message": "Product inserted or updated successfully",
        "product_id": product_id,
        "product_code": product.product_code
    }


@app.get("/products")
def get_products():
    conn = get_connection()
    cur = conn.cursor()

    cur.execute(
        """
        SELECT product_id, product_code, product_name, category, price, created_at
        FROM products
        ORDER BY product_id
        """
    )

    rows = cur.fetchall()
    cur.close()
    conn.close()

    return [
        {
            "product_id": row[0],
            "product_code": row[1],
            "product_name": row[2],
            "category": row[3],
            "price": float(row[4]),
            "created_at": row[5],
        }
        for row in rows
    ]